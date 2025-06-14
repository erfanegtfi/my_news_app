import 'package:app_widgets/image/image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_news_app/di/locator.dart';

/// factory class to load images based on url
/// if asset was empty, it would load empty place holder
Widget loadAssetImage(String? asset, {required double height, required double width}) {
  if (asset == null || asset.isEmpty) {
    return locator.get<ImageLoader>(instanceName: "AssetEmptyImageLoader").loadImage("", height: height, width: width);
  } else {
    return locator.get<ImageLoader>(instanceName: "NetworkImageLoader").loadImage(asset, height: height, width: width);
  }
}
