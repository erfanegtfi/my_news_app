// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDataModel _$NewsDataModelFromJson(Map<String, dynamic> json) =>
    NewsDataModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NewsDataModelToJson(NewsDataModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };
