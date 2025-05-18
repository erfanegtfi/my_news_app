import 'package:app_widgets/image/image_loader.dart';
import 'package:design_system/resources/app_assets.dart';
import 'package:flutter/material.dart';

class AssetEmptyImageLoader implements ImageLoader {
  @override
  Widget loadImage(String path, {double? height, double? width}) {
    return Image.asset(AppAssets.iconPaper, height: height, width: width, package: "design_system");
  }
}
