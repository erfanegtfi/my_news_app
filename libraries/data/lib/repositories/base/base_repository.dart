import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data/model/data_response.dart';
import 'package:design_system/resources/app_text.dart';
import 'package:data/remote/exception/server_error.dart';
import 'package:data/remote/exception/network_connection_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

/// a function to handle api calls and return responce or exception
Future<DataResponse<T>> runService<T>({
  required Future<DataResponse<T>> Function() apiCall,
  DataResponse<T> Function(DioException error)? onDioError,
  DataResponse<T> Function(Object error)? onUnknownError,
}) async {
  DataResponse<T> dataResponse;

  try {
    bool isNetworkConnected = await isConnected;
    if (isNetworkConnected) {
      dataResponse = await apiCall();
    } else {
      dataResponse = DataResponse.error(GeneralError.withAppException(NetworkConnectionException()));
    }
  } on DioException catch (error) {
    dataResponse = onDioError?.call(error) ?? DataResponse.error(GeneralError.withDioError(error));
  } catch (error) {
    debugPrint("unknown error");
    debugPrint(error.toString());
    dataResponse = onUnknownError?.call(error) ?? DataResponse.error(GeneralError.withMessage(AppText.errorUnknown));
  }
  return dataResponse;
}

/// check user has network connection or not
Future<bool> get isConnected async {
  List<ConnectivityResult> result = await Connectivity().checkConnectivity();
  return result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
}
