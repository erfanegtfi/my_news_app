import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'image_loader.dart';

class NetworkImageLoader implements ImageLoader {
  @override
  Widget loadImage(String path, {double? height, double? width}) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: path,
      placeholder: (context, url) => const Icon(Icons.image_outlined),
      errorWidget: (context, url, error) => const Icon(Icons.image_outlined),
    );
  }
}
