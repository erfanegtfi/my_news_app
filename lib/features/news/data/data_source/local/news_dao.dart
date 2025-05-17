import 'package:floor/floor.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';

@dao
abstract class NewstDao {
  @Query("""
  SELECT * FROM News 
  WHERE query = :query 
  AND publishedAt BETWEEN :fromDate AND :toDate
  ORDER BY 
    CASE :sortBy
      WHEN 'newest' THEN publishedAt END DESC,
    CASE :sortBy
      WHEN 'oldest' THEN publishedAt END ASC
  """)
  Future<List<NewsDataModel>> getAllNews(
    String query,
    String fromDate,
    String toDate,
    String sortBy,
  );

  @Query("""
  SELECT * FROM News 
  WHERE query = :query 
  AND publishedAt BETWEEN :fromDate AND :toDate
  ORDER BY 
    CASE :sortBy
      WHEN 'newest' THEN publishedAt END DESC,
    CASE :sortBy
      WHEN 'oldest' THEN publishedAt END ASC
  """)
  Stream<List<NewsDataModel>> getAllNewsAsStream(
    String query,
    String fromDate,
    String toDate,
    String sortBy,
  );

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNews(List<NewsDataModel> news);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNews(List<NewsDataModel> news);

  @delete
  Future<void> deleteNews(NewsDataModel news);
}
