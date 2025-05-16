import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';

@Entity(tableName: "News")
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

  NewsDataModel({this.title, this.description, this.urlToImage, this.publishedAt, this.content});

  News toEntity() {
    return News(
      title: title,
      description: description,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
