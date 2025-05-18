import 'enums/news_query.dart';

class News {
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? author;
  final Source? source;
  final NewsQuery? query;

  News({this.title, this.description, this.urlToImage, this.publishedAt, this.content, this.author, this.source, this.query});
}

class Source {
  final String? name;

  Source({this.name});
}
