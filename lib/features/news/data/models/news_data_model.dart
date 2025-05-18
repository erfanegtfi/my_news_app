import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';

part 'news_data_model.g.dart';

@Entity(tableName: "news")
@JsonSerializable()
class NewsDataModel {
  @PrimaryKey(autoGenerate: false)
  @JsonKey(name: "title")
  @ColumnInfo(name: "title")
  final String? title;
  @JsonKey(name: "description")
  @ColumnInfo(name: "description")
  final String? description;
  @JsonKey(name: "urlToImage")
  @ColumnInfo(name: "urlToImage")
  final String? urlToImage;
  @JsonKey(name: "publishedAt")
  @ColumnInfo(name: "publishedAt")
  final String? publishedAt;
  @JsonKey(name: "content")
  @ColumnInfo(name: "content")
  final String? content;
  @JsonKey(name: "author")
  @ColumnInfo(name: "author")
  final String? author;
  @JsonKey(name: "source")
  @ColumnInfo(name: "source")
  final SourceDataModel source;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @ColumnInfo(name: "qu")
  String? query;

  NewsDataModel(
      {this.title, this.description, this.urlToImage, this.publishedAt, this.content, this.author, required this.source, this.query});

  factory NewsDataModel.fromJson(Map<String, dynamic> json) => _$NewsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDataModelToJson(this);

  News toEntity() {
    return News(
      title: title,
      description: description,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
      author: author,
      source: source.toEntity(),
      query: NewsQuery.fromString(query),
    );
  }
}

@JsonSerializable()
class SourceDataModel {
  @JsonKey(name: "name")
  String? name;

  SourceDataModel({this.name});

  factory SourceDataModel.fromJson(Map<String, dynamic> json) => _$SourceDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceDataModelToJson(this);

  Source toEntity() {
    return Source(
      name: name,
    );
  }
}
