import 'package:floor/floor.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';

@dao
abstract class NewstDao {
  @Query("""
  SELECT * FROM news 
  WHERE qu IN (:queries)
  AND publishedAt >= :fromDate AND publishedAt <= :toDate
  ORDER BY publishedAt DESC
  """)
  Future<List<NewsDataModel>> getAllNews(
    List<String> queries,
    String fromDate,
    String toDate,
  );

  @Query("""
  SELECT * FROM news 
  WHERE qu IN (:queries)
  AND publishedAt >= :fromDate AND publishedAt <= :toDate
  ORDER BY publishedAt DESC
  """)
  Stream<List<NewsDataModel>> getAllNewsAsStream(
    List<String> queries,
    String fromDate,
    String toDate,
  );

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNews(List<NewsDataModel> news);
}
