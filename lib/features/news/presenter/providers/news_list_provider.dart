import 'dart:async';

import 'package:app_utils/constants.dart';
import 'package:app_utils/utils.dart';
import 'package:data/model/data_response.dart';
import 'package:data/remote/exception/server_error.dart';
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
class GetNewsListCubit extends Cubit<GetNewsListViewState> {
  final NewsListAsStreamUsecase newsListAsStreamUsecase;
  final NewsListUsecase newsListUsecase;
  final SortNewsListByQueryUsecase sortNewsUsecase;

  late final String _fromDate;
  late final String _toDate;
  List<News> allNews = [];
  int _currentPage = 1;

  GetNewsListCubit({
    required this.newsListAsStreamUsecase,
    required this.newsListUsecase,
    required this.sortNewsUsecase,
  }) : super(GetNewsListViewState.init()) {
    _fromDate = Utils.getPassedDate(2);
    _toDate = Utils.getCurrentDate();

    newsListAsStreamUsecase(
            NewsOfflineParam(NewsQuery.values.map((e) => e.apiQuery).toList(), _fromDate, _toDate, SortBy.publishedAt.title))
        .listen(
      (news) {
        if (news != null && news.isNotEmpty) {
          allNews.addAll(news);
          _updateSuccessState();
        }
      },
    );
  }

  void getAllNewsList({bool resetPage = false}) {
    if (resetPage) _currentPage = 1;

    if (_currentPage == 1) emit(GetNewsListViewState.loading());

    for (var query in NewsQuery.values) {
      final params = NewsParam(
        query: query.apiQuery,
        fromDate: _fromDate,
        toDate: _toDate,
        sortBy: SortBy.publishedAt.title,
        page: _currentPage,
      );

      _fetchNews(params);
    }

    _currentPage++;
  }

  Future<void> _fetchNews(NewsParam params) async {
    DataResponse<List<News>?> response = await newsListUsecase(params);

    response.when(
      success: (news) {
        if (news != null && news.isNotEmpty) {
          allNews.addAll(news);
          _updateSuccessState();
        }
        debugPrint("news loaded: ${news?.length ?? 0}");
      },
      error: (error) {
        emit(state.copyWith(error: error, loading: false));
      },
    );
  }

  void _updateSuccessState() {
    final sortedNews = sortNewsUsecase(NewsListSortByQueryParam(allNews, myNewsOrder));
    emit(GetNewsListViewState.success(sortedNews));
  }
}

class GetNewsListViewState {
  GeneralError? error;
  List<News>? allNews;
  bool? loading;

  GetNewsListViewState.init();
  GetNewsListViewState.loading() : loading = true;
  GetNewsListViewState.serverError(this.error) : loading = false;
  GetNewsListViewState.success(this.allNews);

  GetNewsListViewState({this.error, this.allNews, this.loading});

  GetNewsListViewState copyWith({GeneralError? error, List<News>? allNews, bool? loading}) {
    return GetNewsListViewState(
      error: error ?? this.error,
      allNews: allNews ?? this.allNews,
      loading: loading ?? this.loading,
    );
  }
}
