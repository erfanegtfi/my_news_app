import 'package:app_widgets/image/asset_empty_image_loader.dart';
import 'package:app_widgets/image/image_loader.dart';
import 'package:app_widgets/image/network_image_loader.dart';
import 'package:data/remote/api_end_points.dart';
import 'package:data/remote/configs/dio_configuration.dart';
import 'package:injectable/injectable.dart';
import 'package:my_news_app/data/local_db/database.dart';
import 'package:my_news_app/navigation/navigation_service.dart';
import 'package:dio/dio.dart';

@module
abstract class RegisterDataModule {
  @Named("baseUrl")
  @LazySingleton(order: -3)
  String get basetUrl => ApiEndPoint.baseApiUrl;

  @lazySingleton
  NavigationService get navigationService => NavigationService();

  @Named("NetworkImageLoader")
  @lazySingleton
  ImageLoader get networkImageLoader => NetworkImageLoader();

  @Named("AssetEmptyImageLoader")
  @lazySingleton
  ImageLoader get assetEmptyImageLoader => AssetEmptyImageLoader();

  // @Injectable(as: ConnectionManager, order: -1)
  // ConnectionManagerImpl get connectionManager;

  @LazySingleton(order: -3)
  Dio get dio {
    return AppDio().getDio();
  }

  @preResolve
  @LazySingleton(order: -3)
  Future<NewsDatabase> initDatabase() async {
    final database = await $FloorNewsDatabase.databaseBuilder('news_database.db').addMigrations([]).build();

    return database;
  }
}
