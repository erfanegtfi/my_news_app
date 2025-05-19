import 'package:data/remote/api_end_points.dart';
import 'package:dio/dio.dart';

/// append apiKey to the end of urls as a query param
class CheckApiKeyInterceptor extends Interceptor {
  CheckApiKeyInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final addUserAgent = options.extra['apiKey'] ?? false;
    if (addUserAgent) {
      options.queryParameters.addAll({
        'apiKey': ApiEndPoint.apiKey,
      });
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    if (error.response?.statusCode == 401) {}
    super.onError(error, handler);
  }
}
