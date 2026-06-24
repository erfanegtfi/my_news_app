import 'package:data/model/data_response.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_offline_param.dart';
import 'package:my_news_app/features/news/domain/usecases/params/news_params.dart';

abstract class NewsRepository {
  Stream<List<News>> getAllNewsAsStream(NewsOfflineParam params);
  Future<List<News>?> getAllNewsLocal(NewsParam params);

  Future<DataResponse<List<News>?>> getAllNewsRemote(NewsParam params);
}
