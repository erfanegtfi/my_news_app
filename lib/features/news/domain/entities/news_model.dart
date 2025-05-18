import 'enums/news_query.dart';

class News {
  String? title;
  String? description;
  String? urlToImage;
  String? publishedAt;
  String? content;
  NewsQuery? query;

  News({this.title, this.description, this.urlToImage, this.publishedAt, this.content, this.query});
}
