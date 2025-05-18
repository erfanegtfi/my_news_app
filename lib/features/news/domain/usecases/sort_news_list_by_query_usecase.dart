import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';

@injectable
class SortNewsListByQueryUsecase {
  List<NewsQuery> myOrder = [
    NewsQuery.microsoft,
    NewsQuery.apple,
    NewsQuery.google,
    NewsQuery.tesla,
  ];

  SortNewsListByQueryUsecase();

  List<News> call(NewsListSortByQueryParam params) {
    final Map<NewsQuery?, List<News>> newsGroups = {};
    final List<News> reorderedNewsList = [];
    int index = 0;

    for (var query in myOrder) newsGroups.putIfAbsent(query, () => []);

    for (final news in params.news) {
      if (news.query != null) {
        newsGroups[news.query]?.add(news);
      }
    }

    bool itemsRemaining = newsGroups.isNotEmpty;

    while (itemsRemaining) {
      itemsRemaining = false;
      for (final query in myOrder) {
        final group = newsGroups[query];
        if (group != null && index < group.length) {
          reorderedNewsList.add(group[index]);
          itemsRemaining = true;
        }
      }
      index++;
    }

    return reorderedNewsList;
  }
}

class NewsListSortByQueryParam {
  List<News> news;

  NewsListSortByQueryParam(this.news);
}
