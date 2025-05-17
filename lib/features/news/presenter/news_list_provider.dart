import 'package:data/model/index_app_response.dart';
import 'package:app_utils/view_state.dart';
import 'package:data/repository_strategy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_as_stream_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';
import 'package:my_news_app/data/di/locator.dart';

final newsProvider = StateNotifierProvider.autoDispose<NewsProviderNotifier, ViewState<List<News>>>((ref) {
  return NewsProviderNotifier(locator<NewsListAsStreamUsecase>(), locator<NewsListUsecase>(), ref);
});

class NewsProviderNotifier extends StateNotifier<ViewState<List<News>>> {
  final NewsListAsStreamUsecase newsListAsStreamUsecase;
  final NewsListUsecase newsListUsecase;

  final Ref ref;
  List<News> allNews = [];

  NewsProviderNotifier(
    this.newsListAsStreamUsecase,
    this.newsListUsecase,
    this.ref,
  ) : super(ViewState.init());

  void getAllnewsList(NewsParam params) async {
    state = ViewState.loading();
    DataResponse<List<News>?> request = await newsListUsecase(params, RepositoryStrategy.remote);
    request.when(
      success: (news) {},
      error: (error) {
        state = ViewState.serverError(error);
      },
    );
  }
}
