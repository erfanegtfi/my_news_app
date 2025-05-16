import 'package:data/model/base_response.dart';
import 'package:dio/dio.dart';
import 'package:design_system/resources/app_text.dart';

import 'dart:convert' as JSON;

import 'package:data/remote/exception/app_exception.dart';
import 'package:data/remote/exception/connection_timeout_exception.dart';
import 'package:data/remote/exception/network_connection_exception.dart';
import 'package:data/remote/exception/unknown_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:sprintf/sprintf.dart';

class GeneralError {
  int? _errorCode;
  String _message = "";
  BaseResponse? _response;
  AppException? _appException;

  int? get errorCode => _errorCode;
  AppException? get appException => _appException;
  BaseResponse? get response => _response;

  set message(String value) {
    _message = value;
  }

  ///get message base on periority
  ///1st:_message
  ///2st:_response.message
  String get message {
    if (_message.isNotEmpty) {
      return _message;
    } else {
      _message = _response?.message ?? _getMessageFromAppException(_appException) ?? AppText.errorUnknown;

      return _message;
    }
  }

  GeneralError._();

  GeneralError.withDioError(DioException? error) {
    if (error != null) {
      _response = _getErrorResponseBody(error);
      _appException = _setErrorType(error);
    }
    if (!kReleaseMode) {
      debugPrint(error.toString());
      if (_response != null) debugPrint(_response?.message.toString());
    }
  }

  GeneralError.withAppException(AppException? appException) {
    if (appException != null) this._appException = appException;
    if (!kReleaseMode) {
      debugPrint(appException?.getMessage());
    }
  }

  GeneralError.withResponse(BaseResponse? response) {
    if (response != null) _response = response;
    if (!kReleaseMode) {
      if (_response != null) debugPrint(_response?.message.toString());
    }
  }

  GeneralError.withMessage(String? message) {
    if (message?.isNotEmpty == true) _message = message!;
    if (!kReleaseMode) {
      debugPrint(message);
    }
  }

  ///get dio error type
  AppException? _setErrorType(DioException? error) {
    AppException? appException;
    _errorCode = error?.response?.statusCode;

    switch (error?.type) {
      case DioExceptionType.cancel:
        appException = UnknownException();
        break;
      case DioExceptionType.unknown:
        appException = UnknownException();
        break;
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        appException = ConnectionTimeoutException();
        break;
      case DioExceptionType.connectionError:
        appException = NetworkConnectionException();
        break;
      case DioExceptionType.badResponse:
        break;
      default:
        break;
    }

    return appException;
  }

  ///convert server error to baseResponse
  BaseResponse? _getErrorResponseBody(DioException? error) {
    BaseResponse? response;
    if (error?.response != null) {
      if (error?.response?.data is Map) {
        response = BaseResponse.fromJson(error?.response?.data);
      } else if (error?.response?.data is String && (error?.response?.data as String).isNotEmpty) {
        try {
          response = BaseResponse.fromJson(JSON.jsonDecode(error?.response?.data));
        } catch (e) {
          return null;
        }
      }
    }
    return response;
  }

  ///get error message based on server error
  String? _getMessageFromAppException(AppException? error) {
    return error?.getMessage();
  }
}
