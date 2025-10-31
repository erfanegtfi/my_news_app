import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';

class NewsListSortByQueryParam {
  List<News> news;
  List<NewsQuery> myOrder;
  NewsListSortByQueryParam(this.news, this.myOrder);
}
