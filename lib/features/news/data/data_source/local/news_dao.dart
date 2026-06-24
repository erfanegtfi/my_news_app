import 'package:froom/froom.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';

@dao
abstract class NewstDao {
  @Query("""
  SELECT * FROM news 
  WHERE  qu = :query
  AND publishedAt >= :fromDate AND publishedAt <= :toDate
  ORDER BY publishedAt DESC 
  LIMIT :pageSize OFFSET (:page - 1) * :pageSize
  """)
  Future<List<NewsDataModel>> getAllNews(
    String query,
    String fromDate,
    String toDate,
    int page,
    int pageSize,
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
