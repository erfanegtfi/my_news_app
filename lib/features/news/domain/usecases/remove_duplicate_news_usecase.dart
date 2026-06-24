import 'package:injectable/injectable.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';

/// sort given news list by your desire query order
@injectable
class RemoveDuplicateNewsUsecase {
  RemoveDuplicateNewsUsecase();

  List<News> call({required List<News>? allNews, required List<News>? newNews}) {
    final map = <String, News>{};

    for (final news in allNews ?? []) map[news.title ?? ""] = news;
    for (final news in newNews ?? []) map[news.title ?? ""] = news;

    return map.values.toList();
  }
}
