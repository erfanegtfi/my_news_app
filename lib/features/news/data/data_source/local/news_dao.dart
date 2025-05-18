import 'package:floor/floor.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';

@dao
abstract class NewstDao {
  @Query("""
  SELECT * FROM news 
  WHERE qu IN (:queries)
  AND publishedAt BETWEEN :fromDate AND :toDate
  ORDER BY 
    CASE :sortBy WHEN 'newest' THEN publishedAt END DESC,
    CASE :sortBy WHEN 'oldest' THEN publishedAt END ASC
  """)
  Future<List<NewsDataModel>> getAllNews(
    List<String> queries,
    String fromDate,
    String toDate,
    String sortBy,
  );

  @Query("""
  SELECT * FROM news 
  WHERE qu IN (:queries)
  AND publishedAt BETWEEN :fromDate AND :toDate
  ORDER BY 
    CASE :sortBy WHEN 'newest' THEN publishedAt END DESC,
    CASE :sortBy WHEN 'oldest' THEN publishedAt END ASC
  """)
  Stream<List<NewsDataModel>> getAllNewsAsStream(
    List<String> queries,
    String fromDate,
    String toDate,
    String sortBy,
  );

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNews(List<NewsDataModel> news);
}
