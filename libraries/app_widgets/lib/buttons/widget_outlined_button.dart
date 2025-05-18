// ignore_for_file: must_be_immutable

import 'package:design_system/resources/export_app_res.dart';
import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final TextStyle? textStyle;
  final Color? color;
  Color? borderColor;

  MyOutlinedButton(
    this.title,
    this.onPressed, {
    this.textStyle,
    this.color,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        // foregroundColor: color ?? appColors().primary,
        side: BorderSide(width: 1, color: borderColor ?? appColors().primary),
        minimumSize: Size(double.infinity, AppDimen.buttonHeight.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.buttonRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(title, style: (textStyle ?? Theme.of(context).textTheme.bodyMedium)?.copyWith(color: color ?? appColors().primary)),
    );
  }
}
