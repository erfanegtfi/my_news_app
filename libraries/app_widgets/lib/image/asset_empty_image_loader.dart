import 'package:app_widgets/image/image_loader.dart';
import 'package:flutter/material.dart';

class AssetEmptyImageLoader implements ImageLoader {
  @override
  Widget loadImage(String path, {double? height, double? width}) {
    return Image.asset(
      'assets/images/lake.jpg',
      height: height,
      width: width,
    );
  }
}
