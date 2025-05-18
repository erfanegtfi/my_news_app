import 'enums/news_query.dart';

class News {
  String? title;
  String? description;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? author;
  Source? source;
  NewsQuery? query;

  News({this.title, this.description, this.urlToImage, this.publishedAt, this.content, this.author, this.source, this.query});
}

class Source {
  String? name;

  Source({this.name});
}
