import 'package:data/model/index_app_response.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/repositories/news_repository.dart';

/// create a remote api call
@injectable
class NewsListUsecase {
  final NewsRepository newsRepository;

  NewsListUsecase({required this.newsRepository});

  Future<DataResponse<List<News>?>> call(NewsParam params) {
    return newsRepository.getAllNewsRemote(params);
  }
}

class NewsParam {
  String query;
  String fromDate;
  String toDate;
  String sortBy;
  int? page;
  int? pageSize;

  NewsParam(this.query, this.fromDate, this.toDate, this.sortBy, this.page, this.pageSize);
}
