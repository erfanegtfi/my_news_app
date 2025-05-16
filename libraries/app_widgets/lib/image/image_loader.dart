import 'package:flutter/material.dart';

abstract class ImageLoader {
  Widget loadImage(String path, {double height, double width});
}
