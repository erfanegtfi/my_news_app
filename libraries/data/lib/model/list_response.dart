import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> extends BaseResponse {
  List<T>? articles;

  ListResponse({int? totalResults, String? status, String? detail, this.articles}) : super(totalResults: totalResults, status: status);

  factory ListResponse.fromJson(dynamic json, Function(Map<String, dynamic>) create) {
    List<T> articles = [];
    json['articles'].forEach((v) {
      articles.add(create(v));
    });

    return ListResponse<T>(articles: articles);
  }
}
