import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final ButtonStyle? buttonStyle;
  final TextStyle? style;
  final Function() onPressed;

  const MyTextButton(
    this.title,
    this.onPressed, {
    this.buttonStyle,
    this.height,
    this.width,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(title, style: style),
      ),
    );
  }
}
