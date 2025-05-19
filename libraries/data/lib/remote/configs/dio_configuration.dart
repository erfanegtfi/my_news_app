import 'package:data/remote/configs/check_api_key_interceptor.dart';
import 'package:dio/dio.dart';

/// initial and config dio
class AppDio {
  late final Dio _dio;

  AppDio() {
    _dio = Dio();
  }

  Dio getDio() {
    _dio.options = BaseOptions(
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {
        "Connection": "keep-alive",
        "Accept-Encoding": "gzip, deflate",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      // responseType: ResponseType.plain,
      // followRedirects: false,
      // validateStatus: (status) {
      //   return status < 500;
      // },
    );

    _addPrettyLoggerInterceptor(_dio);
    _addCheckTokenInterceptor(_dio);

    return _dio;
  }

  _addPrettyLoggerInterceptor(Dio dio) {
    // if (!kReleaseMode)
    //   dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     error: true,
    //     compact: true,
    //     maxWidth: 110,
    //   ));
  }

  _addCheckTokenInterceptor(Dio dio) {
    dio.interceptors.add(CheckApiKeyInterceptor());
  }
}
