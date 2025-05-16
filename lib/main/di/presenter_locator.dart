import 'package:app_widgets/image/asset_empty_image_loader.dart';
import 'package:app_widgets/image/image_loader.dart';
import 'package:app_widgets/image/network_image_loader.dart';
import 'package:my_news_app/main/di/locator.dart';
import 'package:my_news_app/navigation/navigation_service.dart';

void setupAppPresenterLocator() {
  locator.registerLazySingleton(() => NavigationService());

  locator.registerLazySingleton<ImageLoader>(() => NetworkImageLoader(), instanceName: "NetworkImageLoader");
  locator.registerLazySingleton<ImageLoader>(() => AssetEmptyImageLoader(), instanceName: "AssetEmptyImageLoader");
}
