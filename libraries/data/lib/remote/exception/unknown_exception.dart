import 'package:design_system/resources/app_text.dart';

import 'app_exception.dart';

class UnknownException implements AppException {
  String? message;
  UnknownException({this.message});

  @override
  String getMessage() {
    return message ?? AppText.errorUnknown;
  }
}
