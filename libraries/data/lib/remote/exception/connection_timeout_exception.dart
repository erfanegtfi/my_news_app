import 'package:design_system/resources/app_text.dart';

import 'app_exception.dart';

class ConnectionTimeoutException implements AppException {
  String? message;
  ConnectionTimeoutException({this.message});

  @override
  String getMessage() {
    return message ?? AppText.serverErrorConnectionTimeout;
  }
}
