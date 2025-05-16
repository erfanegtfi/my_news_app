import 'package:floor/floor.dart';
import 'package:my_news_app/data/local_db/database.dart';
import 'package:my_news_app/main/di/locator.dart';

void setupDatabaseLocator() {
  locator.registerSingletonAsync<NewsDatabase>(() async {
    final database = await $FloorNewsDatabase.databaseBuilder('news_database.db').addMigrations([]).build();
    return database;
  });
}
