import 'dart:async';

import 'package:app_utils/constants.dart';
import 'package:app_utils/utils.dart';
import 'package:data/model/index_app_response.dart';
import 'package:app_utils/view_state.dart';
import 'package:data/remote/exception/server_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/enums/sort_by.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_as_stream_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/sort_news_list_by_query_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';
import 'package:my_news_app/data/di/locator.dart';
import 'package:rxdart/rxdart.dart';

final newsProvider = StateNotifierProvider.autoDispose<NewsProviderNotifier, ViewState<List<News>>>((ref) {
  return NewsProviderNotifier(locator<NewsListAsStreamUsecase>(), locator<NewsListUsecase>(), locator<SortNewsListByQueryUsecase>(), ref);
});

class NewsProviderNotifier extends StateNotifier<ViewState<List<News>>> {
  final PublishSubject<GeneralError> errorPublisher = PublishSubject();

  final NewsListAsStreamUsecase newsListAsStreamUsecase;
  final NewsListUsecase newsListUsecase;
  final SortNewsListByQueryUsecase newsListSortByQueryUsecase;

  final Ref ref;
  List<News> allNews = [];
  int page = 1;
  late final String _fromDate;
  late final String _toDate;
  StreamSubscription<List<News>?>? sub;

  NewsProviderNotifier(
    this.newsListAsStreamUsecase,
    this.newsListUsecase,
    this.newsListSortByQueryUsecase,
    this.ref,
  ) : super(ViewState.init()) {
    _fromDate = Utils.getPassedDate(2);
    _toDate = Utils.getCurrentDate();

    NewsOfflineParam param =
        NewsOfflineParam(NewsQuery.values.map((e) => e.apiQuery).toList(), _fromDate, _toDate, SortBy.publishedAt.title);
    sub = newsListAsStreamUsecase.call(param).listen(
      (event) {
        if (event != null) {
          allNews.clear();
          allNews.addAll(event);
        }
        if (allNews.isNotEmpty == true) _setSuccessState();
        debugPrint("${event?.length}");
      },
    );
  }

  void getAllNewsList({bool resetPage = false}) {
    if (resetPage) {
      page = 1;
    }
    if (page == 1) state = ViewState.loading();

    for (var query in NewsQuery.values) {
      _callApi(NewsParam(query.apiQuery, _fromDate, _toDate, SortBy.publishedAt.title, page, Constants.LIST_PAGE_SIZE));
    }
    page++;
  }

  void _callApi(NewsParam params) async {
    DataResponse<List<News>?> request = await newsListUsecase(params);
    request.when(
      success: (news) {
        if (state is Loading) _setSuccessState();
      },
      error: (error) {
        errorPublisher.sink.add(error);
        if (allNews.isNotEmpty == true)
          _setSuccessState();
        else
          state = ViewState.serverError(error);
      },
    );
  }

  _setSuccessState() {
    state = ViewState.success(newsListSortByQueryUsecase.call(NewsListSortByQueryParam(allNews, myNewsOrder)));
  }

  @override
  void dispose() {
    errorPublisher.close();
    sub?.cancel();
    super.dispose();
  }
}
