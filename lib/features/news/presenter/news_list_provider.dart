import 'package:app_utils/constants.dart';
import 'package:app_utils/utils.dart';
import 'package:data/model/index_app_response.dart';
import 'package:app_utils/view_state.dart';
import 'package:data/remote/exception/network_connection_exception.dart';
import 'package:data/repository_strategy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/enums/sort_by.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_as_stream_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/sort_news_list_by_query_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';
import 'package:my_news_app/data/di/locator.dart';

final newsProvider = StateNotifierProvider.autoDispose<NewsProviderNotifier, ViewState<List<News>>>((ref) {
  return NewsProviderNotifier(locator<NewsListAsStreamUsecase>(), locator<NewsListUsecase>(), locator<SortNewsListByQueryUsecase>(), ref);
});

class NewsProviderNotifier extends StateNotifier<ViewState<List<News>>> {
  final NewsListAsStreamUsecase newsListAsStreamUsecase;
  final NewsListUsecase newsListUsecase;
  final SortNewsListByQueryUsecase newsListSortByQueryUsecase;

  final Ref ref;
  List<News> allNews = [];
  int page = 1;
  late final String _fromDate;
  late final String _toDate;

  NewsProviderNotifier(
    this.newsListAsStreamUsecase,
    this.newsListUsecase,
    this.newsListSortByQueryUsecase,
    this.ref,
  ) : super(ViewState.init()) {
    _fromDate = Utils.getPassedDate(1);
    _toDate = Utils.getCurrentDate();

    NewsOfflineParam param =
        NewsOfflineParam(NewsQuery.values.map((e) => e.apiQuery).toList(), _fromDate, _toDate, SortBy.publishedAt.title);
    newsListAsStreamUsecase.call(param).listen(
      (event) {
        if (event != null) {
          allNews.clear();
          allNews.addAll(event);
        }
        if (allNews.isNotEmpty == true) state = ViewState.success(newsListSortByQueryUsecase.call(NewsListSortByQueryParam(allNews)));
        print("${event?.length}");
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
      success: (news) {},
      error: (error) {
        if (allNews.isNotEmpty != true) state = ViewState.serverError(error);
      },
    );
  }
}
