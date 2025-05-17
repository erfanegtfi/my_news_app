import 'package:data/model/index_app_response.dart';
import 'package:data/repository_strategy.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';
import 'package:my_news_app/features/news/domain/repositories/news_repository.dart';

@injectable
class NewsListUsecase {
  final NewsRepository newsRepository;

  NewsListUsecase({required this.newsRepository});

  Future<DataResponse<List<News>?>> call(NewsParam params, RepositoryStrategy strategy) {
    return newsRepository.getAllNewsRemote(params);
  }
}

// class NewsListUsecase {
//   final NewsRepository newsRepository;

//   NewsListUsecase({required this.newsRepository});

//   Stream<DataResponse<List<News>?>> call(NewsParam params, RepositoryStrategy strategy) async* {
//     if (strategy == RepositoryStrategy.offlineFirst) {
//       yield DataResponse.success(await newsRepository.getAllNewsLocal(params));
//       yield await newsRepository.getAllNewsRemote(params);
//     } else if (strategy == RepositoryStrategy.offline) {
//       yield DataResponse.success(await newsRepository.getAllNewsLocal(params));
//     } else {
//       yield await newsRepository.getAllNewsRemote(params);
//     }
//   }
// }

class NewsParam {
  // List<String>? querys;
  String query;
  String fromDate;
  String toDate;
  String sortBy;
  int? page;
  int? pageSize;

  NewsParam(this.query, this.fromDate, this.toDate, this.sortBy, this.page, this.pageSize);
}
