import 'package:data/model/list_response.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'news_rest_client.g.dart';

@injectable
@RestApi()
abstract class NewsRestClient {
  @factoryMethod
  factory NewsRestClient(Dio dio, {@Named("baseUrl") String baseUrl}) = _NewsRestClient;

  @GET("everything")
  Future<ListResponse<NewsDataModel>> getAllNews({
    @Query("q") String? query,
    @Query("from") String? fromDate,
    @Query("to") String? toDate,
    @Query("sortBy") String? sortBy,
    @Query("page") int? page,
    @Query("pageSize") int? pageSize,
  });
}
