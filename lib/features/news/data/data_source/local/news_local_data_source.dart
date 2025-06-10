import 'package:injectable/injectable.dart';
import 'package:my_news_app/database/database.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_as_stream_usecase.dart';

abstract class NewsLocalDataSource {
  Stream<List<NewsDataModel>> getAllNewsAsStream(NewsOfflineParam params);
  Future<List<NewsDataModel>> getAllNews(NewsOfflineParam params);
  Future<void> insertNews(List<NewsDataModel> news);
}

@Injectable(as: NewsLocalDataSource)
class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final NewsDatabase database;

  NewsLocalDataSourceImpl({required this.database});

  @override
  Stream<List<NewsDataModel>> getAllNewsAsStream(NewsOfflineParam params) {
    return database.newstDao.getAllNewsAsStream(params.queries ?? [], params.fromDate, params.toDate);
  }

  @override
  Future<List<NewsDataModel>> getAllNews(NewsOfflineParam params) {
    return database.newstDao.getAllNews(params.queries ?? [], params.fromDate, params.toDate); //  params.sortBy
  }

  @override
  Future<void> insertNews(List<NewsDataModel> news) {
    return database.newstDao.insertNews(news);
  }
}
