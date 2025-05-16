import 'package:flutter/material.dart';
import 'package:design_system/resources/colors/colors.dart';

class LightColors implements MyColors {
  const LightColors();
  @override
  Color get appbarBackground => const Color(0xFFFFFFFF);

  @override
  Color get primary => const Color(0xff1c53f4);

  @override
  Color get screenBackground => const Color(0xFFFaFaFa);

  @override
  Color get secondery => Colors.white;

  @override
  Color get textBlack => const Color(0xFF111111);

  @override
  Color get textError => const Color(0xFFff3952);

  @override
  Color get listDivider => const Color(0xFFdadada);

  @override
  Color get textGrey => const Color(0xFF9ca3af);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get black => const Color(0xFFFFFFFF);

  @override
  Color get icon => const Color(0xFF717AA0);
}
