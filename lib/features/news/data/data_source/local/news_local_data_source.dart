import 'package:injectable/injectable.dart';
import 'package:my_news_app/data/local_db/database.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';

abstract class NewsLocalDataSource {
  Stream<List<NewsDataModel>> getAllNewsAsStream(NewsParam params);
  Future<List<NewsDataModel>> getAllNews(NewsParam params);
  Future<void> insertNews(List<NewsDataModel> news);
  Future<void> updateNews(List<NewsDataModel> news);
}

@Injectable(as: NewsLocalDataSource)
class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final NewsDatabase database;

  NewsLocalDataSourceImpl({required this.database});

  @override
  Stream<List<NewsDataModel>> getAllNewsAsStream(NewsParam params) {
    return database.newstDao.getAllNewsAsStream(params.query, params.fromDate, params.toDate, params.sortBy);
  }

  @override
  Future<List<NewsDataModel>> getAllNews(NewsParam params) {
    return database.newstDao.getAllNews(params.query, params.fromDate, params.toDate, params.sortBy);
  }

  @override
  Future<void> insertNews(List<NewsDataModel> news) {
    return database.newstDao.insertNews(news);
  }

  @override
  Future<void> updateNews(List<NewsDataModel> news) {
    return database.newstDao.updateNews(news);
  }
}
