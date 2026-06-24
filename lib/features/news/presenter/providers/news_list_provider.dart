import 'dart:async';

import 'package:app_utils/constants.dart';
import 'package:app_utils/utils.dart';
import 'package:app_utils/view_state.dart';
import 'package:data/repository_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/enums/sort_by.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_as_stream_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_list_sort_by_query_param.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_params.dart';
import 'package:my_news_app/features/news/domain/usecases/remove_duplicate_news_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/sort_news_list_by_query_usecase.dart';

@injectable
class GetNewsListCubit extends Cubit<ViewState<List<News>>> {
  final NewsListAsStreamUsecase newsListAsStreamUsecase;
  final NewsListUsecase newsListUsecase;
  final SortNewsListByQueryUsecase sortNewsUsecase;
  final RemoveDuplicateNewsUsecase removeDuplicateNewsUsecase;

  late final String _fromDate;
  late final String _toDate;
  List<News> allNews = [];
  int _currentPage = 1;

  GetNewsListCubit(
      {required this.newsListAsStreamUsecase,
      required this.newsListUsecase,
      required this.sortNewsUsecase,
      required this.removeDuplicateNewsUsecase})
      : super(const ViewState.init()) {
    _fromDate = Utils.getPassedDate(2);
    _toDate = Utils.getCurrentDate();
  }

  void getAllNewsList({bool resetPage = false}) {
    if (resetPage) _currentPage = 1;

    if (_currentPage == 1) emit(ViewState.loading());

    for (var query in NewsQuery.values) {
      final params = NewsParam(
        query: query.apiQuery,
        fromDate: _fromDate,
        toDate: _toDate,
        sortBy: SortBy.publishedAt.title,
        page: _currentPage,
      );

      _fetchNews(params, LoadStrategy.offlineFirst);
    }

    _currentPage++;
  }

  Future<void> _fetchNews(
    NewsParam params,
    LoadStrategy strategy,
  ) async {
    await newsListUsecase(
      strategy,
      params,
      (result) {
        result.when(
          success: (news) {
            if (news != null && news.isNotEmpty) {
              allNews.addAll(news);
              allNews = removeDuplicateNewsUsecase(allNews: allNews, newNews: news);
              _updateSuccessState();
            }
            debugPrint("news loaded: ${news?.length ?? 0}");
          },
          error: (error) {
            emit(ViewState.serverError(error));
          },
        );
      },
    );
  }

  void _updateSuccessState() {
    final sortedNews = sortNewsUsecase(NewsListSortByQueryParam(allNews, myNewsOrder));
    emit(ViewState.success(sortedNews));
  }
}
