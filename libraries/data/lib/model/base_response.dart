/// base response is a common fields that all apis have
/// status, totalResults, message and code
class BaseResponse {
  String? status;
  int? totalResults;
  String? message;
  String? code;

  BaseResponse({this.totalResults, this.status, this.code, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(status: json["status"], totalResults: json["totalResults"], code: json["code"], message: json["message"]);
  }
}
