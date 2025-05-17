import 'package:data/model/index_app_response.dart';
import 'package:data/repository_strategy.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';
import 'package:my_news_app/features/news/domain/repositories/news_repository.dart';

import 'news_list_usecase.dart';

@injectable
class NewsListAsStreamUsecase {
  final NewsRepository newsRepository;

  NewsListAsStreamUsecase({required this.newsRepository});

  Stream<List<News>?> call(NewsParam params, RepositoryStrategy strategy) {
    return newsRepository.getAllNewsAsStream(params);
  }
}

// class NewsParam {
//   // List<String>? querys;
//   String query;
//   String fromDate;
//   String toDate;
//   String sortBy;
//   int? page;
//   int? pageSize;

//   NewsParam(this.query, this.fromDate, this.toDate, this.sortBy, this.page, this.pageSize);
// }
