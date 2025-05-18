import 'package:flutter_test/flutter_test.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';
import 'package:my_news_app/features/news/domain/usecases/sort_news_list_by_query_usecase.dart';

void main() {
  group('interleaveNewsByQueryOrder', () {
    SortNewsListByQueryUsecase sortNewsListByQueryUsecase = SortNewsListByQueryUsecase();

    test('should sort news in my order', () {
      final newsList = [
        News(title: "M1", query: NewsQuery.microsoft),
        News(title: "M2", query: NewsQuery.microsoft),
        News(title: "A1", query: NewsQuery.apple),
        News(title: "A2", query: NewsQuery.apple),
        News(title: "G1", query: NewsQuery.google),
        News(title: "G2", query: NewsQuery.google),
        News(title: "T1", query: NewsQuery.tesla),
        News(title: "T2", query: NewsQuery.tesla),
      ];

      final result = sortNewsListByQueryUsecase.call(NewsListSortByQueryParam(newsList));

      expect(result[0].title, "M1");
      expect(result[1].title, "A1");
      expect(result[2].title, "G1");
      expect(result[3].title, "T1");
      expect(result[4].title, "M2");
      expect(result[5].title, "A2");
      expect(result[6].title, "G2");
      expect(result[7].title, "T2");
    });

    test('should handle bad group sizes', () {
      final newsList = [
        News(title: "M1", query: NewsQuery.microsoft),
        News(title: "M2", query: NewsQuery.microsoft),
        News(title: "M3", query: NewsQuery.microsoft),
        News(title: "A1", query: NewsQuery.apple),
        News(title: "G1", query: NewsQuery.google),
      ];

      final result = sortNewsListByQueryUsecase.call(NewsListSortByQueryParam(newsList));

      expect(result[0].title, "M1");
      expect(result[1].title, "A1");
      expect(result[2].title, "G1");
      expect(result[3].title, "M2");
      expect(result[4].title, "M3");
    });

    test('should handle null queries', () {
      final newsList = [
        News(title: "NoQuery", query: null),
        News(title: "M1", query: NewsQuery.microsoft),
        News(title: "A1", query: NewsQuery.apple),
      ];

      final result = sortNewsListByQueryUsecase.call(NewsListSortByQueryParam(newsList));

      expect(result[0].title, "M1");
      expect(result[1].title, "A1");
      expect(result.length, 2);
    });

    test('should handle empty list', () {
      final result = sortNewsListByQueryUsecase.call(NewsListSortByQueryParam([]));
      expect(result, isEmpty);
    });

    test('should handle missing query types', () {
      final newsList = [
        News(title: "M1", query: NewsQuery.microsoft),
        News(title: "T1", query: NewsQuery.tesla),
      ];

      final result = sortNewsListByQueryUsecase.call(NewsListSortByQueryParam(newsList));

      expect(result[0].title, "M1");
      expect(result[1].title, "T1");
    });
  });
}
