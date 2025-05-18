import 'dart:async';
import 'package:dio/dio.dart';
import 'package:data/repositories/base/base_repository.dart';
import 'package:data/model/index_app_response.dart';
import 'package:data/remote/exception/server_error.dart';
import 'package:design_system/resources/app_text.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/data/data_source/local/news_local_data_source.dart';
import 'package:my_news_app/features/news/data/data_source/remote/news_remote_data_source.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';
import 'package:my_news_app/features/news/domain/repositories/news_repository.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_as_stream_usecase.dart';
import 'package:my_news_app/features/news/domain/usecases/news_list_usecase.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final NewsLocalDataSource newsLocalDataSource;

  NewsRepositoryImpl({required this.newsLocalDataSource, required this.newsRemoteDataSource});

  @override
  Future<DataResponse<List<News>?>> getAllNewsRemote(NewsParam params) async {
    DataResponse<List<News>?> dataResponse;

    dataResponse = await runService(
      apiCall: () async {
        ListResponse<NewsDataModel> response = await newsRemoteDataSource.getAllNews(params);
        if (response.articles != null && response.articles?.isNotEmpty == true) {
          List<News> articles = response.articles!.map((news) {
            news.query = params.query;
            return news.toEntity();
          }).toList();

          newsLocalDataSource.insertNews(response.articles!);

          return DataResponse.success(articles);
        } else {
          return DataResponse.success(List.empty());
        }
      },
      onDioError: (error) {
        return DataResponse.error(GeneralError.withDioError(error));
      },
      onUnknownError: (error) {
        return DataResponse.error(GeneralError.withMessage(AppText.errorUnknown));
      },
    );

    // try {
    //   ListResponse<NewsDataModel> response = await newsRemoteDataSource.getAllNews(params);
    //   if (response.articles != null && response.articles?.isNotEmpty == true) {
    //     dataResponse = DataResponse.success(response.articles!.map((news) {
    //       news.query = params.query;
    //       return news.toEntity();
    //     }).toList());
    //     newsLocalDataSource.insertNews(response.articles!);
    //   } else {
    //     dataResponse = DataResponse.success(List.empty());
    //   }
    // } on DioException catch (error) {
    //   dataResponse = DataResponse.error(GeneralError.withDioError(error));
    // } catch (error) {
    //   dataResponse = DataResponse.error(GeneralError.withMessage(AppText.errorUnknown));
    // }

    return dataResponse;
  }

  @override
  Future<List<News>?> getAllNewsLocal(NewsOfflineParam params) async {
    List<NewsDataModel> response = await newsLocalDataSource.getAllNews(params);
    return response.map((news) => news.toEntity()).toList();
  }

  @override
  Stream<List<News>> getAllNewsAsStream(NewsOfflineParam params) {
    return newsLocalDataSource.getAllNewsAsStream(params).map((news) => news.map((item) => item.toEntity()).toList());
  }
}
