import 'dart:async';

import 'package:floor/floor.dart';
import 'package:my_news_app/features/news/data/data_source/local/news_dao.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [NewsDataModel])
abstract class NewsDatabase extends FloorDatabase {
  NewstDao get newstDao;
}
