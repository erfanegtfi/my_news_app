import 'package:flutter/material.dart';
import 'package:design_system/resources/export_app_res.dart';

class MyBackground extends StatelessWidget {
  final Widget child;
  final Color? colorBack;
  final Color? colorBorder;
  final double borderwidth;
  final double radius;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const MyBackground({
    required this.child,
    this.width,
    this.height,
    this.colorBack,
    this.colorBorder,
    this.borderwidth = 1,
    this.radius = AppDimen.radiusNormal,
    this.padding = const EdgeInsets.all(AppDimen.spacingNormal),
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: colorBorder ?? appColors().gray, width: borderwidth),
        color: colorBack ?? appColors().gray,
      ),
      child: child,
    );
  }
}
