import 'dart:async';

import 'package:data/model/index_app_response.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/repositories/news_repository.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_params.dart';
import 'package:data/repository_strategy.dart';

@injectable
class NewsListUsecase {
  final NewsRepository newsRepository;

  NewsListUsecase({
    required this.newsRepository,
  });

  Future<void> call(
    LoadStrategy strategy,
    NewsParam newsParam,
    void Function(DataResponse<List<News>?>) callback,
  ) async {
    if (strategy == LoadStrategy.remote) callback(await newsRepository.getAllNewsRemote(newsParam));
    if (strategy == LoadStrategy.offline) callback(DataResponse.success(await newsRepository.getAllNewsLocal(newsParam)));
    if (strategy == LoadStrategy.offlineFirst) {
      callback(DataResponse.success(await newsRepository.getAllNewsLocal(newsParam)));
      callback(await newsRepository.getAllNewsRemote(newsParam));
    }
  }
}
