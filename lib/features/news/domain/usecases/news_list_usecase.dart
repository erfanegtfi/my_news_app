import 'package:data/model/index_app_response.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/repositories/news_repository.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_params.dart';

/// create a remote api call
@injectable
class NewsListUsecase {
  final NewsRepository newsRepository;

  NewsListUsecase({required this.newsRepository});

  Future<DataResponse<List<News>?>> call(NewsParam params) {
    return newsRepository.getAllNewsRemote(params);
  }
}
