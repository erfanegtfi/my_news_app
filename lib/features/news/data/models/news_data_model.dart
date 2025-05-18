import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';

part 'news_data_model.g.dart';

@Entity(tableName: "news")
@JsonSerializable()
class NewsDataModel {
  @PrimaryKey(autoGenerate: false)
  @JsonKey(name: "title")
  @ColumnInfo(name: "title")
  String? title;
  @JsonKey(name: "description")
  @ColumnInfo(name: "description")
  String? description;
  @JsonKey(name: "urlToImage")
  @ColumnInfo(name: "urlToImage")
  String? urlToImage;
  @JsonKey(name: "publishedAt")
  @ColumnInfo(name: "publishedAt")
  String? publishedAt;
  @JsonKey(name: "content")
  @ColumnInfo(name: "content")
  String? content;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @ColumnInfo(name: "qu")
  String? query;

  NewsDataModel({this.title, this.description, this.urlToImage, this.publishedAt, this.content});

  factory NewsDataModel.fromJson(Map<String, dynamic> json) => _$NewsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDataModelToJson(this);

  News toEntity() {
    return News(
      title: title,
      description: description,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
      query: query,
    );
  }
}
