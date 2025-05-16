import 'package:data/remote/exception/server_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_response.freezed.dart';

@freezed
abstract class DataResponse<T> with _$DataResponse<T> {
  const factory DataResponse.success(T res) = Success<T>;
  const factory DataResponse.error(GeneralError error) = Error;
}
