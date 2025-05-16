import 'package:design_system/resources/app_text.dart';

import 'app_exception.dart';

class NetworkConnectionException implements AppException {
  String? message;
  NetworkConnectionException({this.message});

  @override
  String getMessage() {
    return message ?? AppText.errorNetworkConnection;
  }
}
