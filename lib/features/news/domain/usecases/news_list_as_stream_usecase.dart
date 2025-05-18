import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/repositories/news_repository.dart';

/// Return all news list as a stream.
/// Every time list changed in database this stream automatically retrun a new list
@injectable
class NewsListAsStreamUsecase {
  final NewsRepository newsRepository;

  NewsListAsStreamUsecase({required this.newsRepository});

  Stream<List<News>?> call(NewsOfflineParam params) {
    return newsRepository.getAllNewsAsStream(params);
  }
}

class NewsOfflineParam {
  List<String>? queries;
  String fromDate;
  String toDate;
  String sortBy;

  NewsOfflineParam(this.queries, this.fromDate, this.toDate, this.sortBy);
}
