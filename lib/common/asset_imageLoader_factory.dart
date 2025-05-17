import 'package:app_widgets/image/image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_news_app/data/di/locator.dart';

/// factory
Widget loadAssetImage(String? asset) {
  if (asset == null || asset.isEmpty) {
    return locator.get<ImageLoader>(instanceName: "AssetEmptyImageLoader").loadImage("");
  } else {
    return locator.get<ImageLoader>(instanceName: "NetworkImageLoader").loadImage(asset);
  }
}
