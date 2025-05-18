import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:my_news_app/features/news/data/models/news_data_model.dart';

class SourceConverter extends TypeConverter<SourceDataModel, String> {
  @override
  SourceDataModel decode(String databaseValue) {
    return SourceDataModel.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(SourceDataModel value) {
    return json.encode(value.toJson());
  }
}
