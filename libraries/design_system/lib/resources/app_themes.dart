import 'package:design_system/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:design_system/resources/app_dimen.dart';
import 'package:design_system/resources/colors/colors.dart';
import 'package:design_system/resources/colors/light_colors.dart';
import 'package:flutter/services.dart';

MyColors appColors() {
  return LightColors();
}

const lightColors = LightColors();

final ThemeData lightTheme = ThemeData(
  primaryColor: lightColors.primary,
  useMaterial3: false,
  colorScheme: ColorScheme.light(
    primary: lightColors.primary,
    primaryContainer: lightColors.primary,
    onPrimary: lightColors.white,
    secondary: lightColors.secondery,
    secondaryContainer: lightColors.secondery,
    surface: lightColors.screenBackground,
    onError: lightColors.white,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: lightColors.screenBackground,
  iconTheme: IconThemeData(color: lightColors.icon, size: AppDimen.iconSize),
  brightness: Brightness.light,
  dividerTheme: DividerThemeData(color: lightColors.listDivider),
  appBarTheme: AppBarTheme(
      backgroundColor: lightColors.appbarBackground,
      iconTheme: IconThemeData(color: lightColors.icon),
      systemOverlayStyle: SystemUiOverlayStyle.dark),
  textTheme: TextTheme(
    displayLarge: textDisplayLarge.copyWith(color: lightColors.textBlack),
    displayMedium: textDisplayMedium.copyWith(color: lightColors.textBlack),
    displaySmall: textDisplaySmall.copyWith(color: lightColors.textBlack),
    headlineLarge: textHeadLinelarge.copyWith(color: lightColors.textBlack),
    headlineMedium: textHeadLineMedium.copyWith(color: lightColors.textBlack),
    headlineSmall: textHeadLineSmall.copyWith(color: lightColors.textBlack),
    titleLarge: textTitlelarge.copyWith(color: lightColors.textBlack),
    titleMedium: textTitleMedium.copyWith(color: lightColors.textBlack),
    titleSmall: textTitleSmall.copyWith(color: lightColors.textBlack),
    bodyLarge: textBodylarge.copyWith(color: lightColors.textBlack),
    bodyMedium: textBodyMedium.copyWith(color: lightColors.textBlack),
    bodySmall: textBodySmall.copyWith(color: lightColors.textBlack),
    labelLarge: textLablelarge.copyWith(color: lightColors.textGrey),
    labelMedium: textLableMedium.copyWith(color: lightColors.textGrey),
    labelSmall: textLableSmall.copyWith(color: lightColors.textGrey),
  ),
);
