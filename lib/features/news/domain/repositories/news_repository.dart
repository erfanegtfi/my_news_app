import 'package:data/model/data_response.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';

abstract class NewsRepository {
  Stream<List<News>> getAllNewsAsStream(NewsParam params);

  Future<DataResponse<List<News>?>> getAllNewsRemote(NewsParam params);
  Future<List<News>?> getAllNewsLocal(NewsParam params);
}
