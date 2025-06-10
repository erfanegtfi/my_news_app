import 'dart:async';

import 'package:app_utils/constants.dart';
import 'package:app_utils/utils.dart';
import 'package:app_utils/view_state.dart';
import 'package:data/remote/exception/server_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/di/locator.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/enums/sort_by.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_as_stream_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/sort_news_list_by_query_usecase.dart';
import 'package:rxdart/rxdart.dart';

final newsProvider = StateNotifierProvider.autoDispose<NewsProviderNotifier, ViewState<List<News>>>((ref) {
  return NewsProviderNotifier(
    locator<NewsListAsStreamUsecase>(),
    locator<NewsListUsecase>(),
    locator<SortNewsListByQueryUsecase>(),
    ref,
  );
});

class NewsProviderNotifier extends StateNotifier<ViewState<List<News>>> {
  final Ref ref;
  final NewsListAsStreamUsecase newsListAsStreamUsecase;
  final NewsListUsecase newsListUsecase;
  final SortNewsListByQueryUsecase sortNewsUsecase;

  final PublishSubject<GeneralError> errorPublisher = PublishSubject();

  late final String _fromDate;
  late final String _toDate;

  List<News> allNews = [];
  int _currentPage = 1;
  StreamSubscription<List<News>?>? _subscription;

  NewsProviderNotifier(
    this.newsListAsStreamUsecase,
    this.newsListUsecase,
    this.sortNewsUsecase,
    this.ref,
  ) : super(ViewState.init()) {
    _fromDate = Utils.getPassedDate(2);
    _toDate = Utils.getCurrentDate();

    _subscribeToOfflineNews();
  }

  void _subscribeToOfflineNews() {
    final offlineParam = NewsOfflineParam(
      NewsQuery.values.map((e) => e.apiQuery).toList(),
      _fromDate,
      _toDate,
      SortBy.publishedAt.title,
    );

    _subscription = newsListAsStreamUsecase(offlineParam).listen((event) {
      if (event != null && event.isNotEmpty) {
        allNews = List<News>.from(event);
        _updateSuccessState();
      }
      debugPrint("Offline news loaded: ${event?.length ?? 0}");
    });
  }

  void getAllNewsList({bool resetPage = false}) {
    if (resetPage) _currentPage = 1;

    if (_currentPage == 1) state = ViewState.loading();

    for (var query in NewsQuery.values) {
      final params = NewsParam(
        query.apiQuery,
        _fromDate,
        _toDate,
        SortBy.publishedAt.title,
        _currentPage,
        Constants.LIST_PAGE_SIZE,
      );
      _fetchNews(params);
    }

    _currentPage++;
  }

  Future<void> _fetchNews(NewsParam params) async {
    final result = await newsListUsecase(params);
    result.when(
      success: (_) {},
      error: (error) {
        if (allNews.isNotEmpty) {
          errorPublisher.add(error);
          _updateSuccessState();
        } else {
          state = ViewState.serverError(error);
        }
      },
    );
  }

  void _updateSuccessState() {
    final sortedNews = sortNewsUsecase(
      NewsListSortByQueryParam(allNews, myNewsOrder),
    );
    state = ViewState.success(sortedNews);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    errorPublisher.close();
    super.dispose();
  }
}
