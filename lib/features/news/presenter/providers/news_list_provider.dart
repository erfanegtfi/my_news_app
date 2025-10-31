import 'dart:async';

import 'package:app_utils/constants.dart';
import 'package:app_utils/utils.dart';
import 'package:app_utils/view_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/enums/sort_by.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_as_stream_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_list_sort_by_query_param.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_offline_param.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_params.dart';
import 'package:my_news_app/features/news/domain/usecases/sort_news_list_by_query_usecase.dart';

@injectable
class GetNewsListCubit extends Cubit<ViewState<List<News>>> {
  final NewsListAsStreamUsecase newsListAsStreamUsecase;
  final NewsListUsecase newsListUsecase;
  final SortNewsListByQueryUsecase sortNewsUsecase;

  late final String _fromDate;
  late final String _toDate;
  List<News> allNews = [];
  int _currentPage = 1;
  StreamSubscription<List<News>?>? _subscription;

  GetNewsListCubit({required this.newsListAsStreamUsecase, required this.newsListUsecase, required this.sortNewsUsecase})
      : super(const ViewState.init()) {
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

    if (_currentPage == 1) emit(ViewState.loading());

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
        emit(ViewState.serverError(error));
      },
    );
  }

  void _updateSuccessState() {
    final sortedNews = sortNewsUsecase(NewsListSortByQueryParam(allNews, myNewsOrder));
    emit(ViewState.success(sortedNews));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
