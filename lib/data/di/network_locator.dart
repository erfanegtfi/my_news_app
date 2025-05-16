import 'package:data/remote/configs/dio_configuration.dart';
import 'package:my_news_app/main/di/locator.dart';
import 'package:dio/dio.dart';

void setupNetworkLocator() {
  locator.registerFactory<Dio>(() => AppDio.instance.getDio());
}
