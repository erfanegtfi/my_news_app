import 'package:data/model/index_app_response.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';

import 'news_rest_client.dart';

abstract class NewsRemoteDataSource {
  Future<ListResponse<NewsDataModel>> getAllNews(NewsParam params);
}

@Injectable(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final NewsRestClient restClient;

  NewsRemoteDataSourceImpl({required this.restClient});

  @override
  Future<ListResponse<NewsDataModel>> getAllNews(NewsParam params) {
    return restClient.getAllNews(
      query: params.query,
      fromDate: params.fromDate,
      toDate: params.toDate,
      sortBy: params.sortBy,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}
