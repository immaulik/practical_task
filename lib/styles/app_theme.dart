import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/const/color_const.dart';
import 'package:practical_task/const/font_const.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get appTheme => ThemeData(
        fontFamily: FontConst.metropolis,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConst.seed,
          primary: ColorConst.primary,
          onPrimary: ColorConst.onPrimary,
          surface: ColorConst.surface,
        ),
        scaffoldBackgroundColor: ColorConst.onSurface,
        appBarTheme: AppBarTheme(
            toolbarHeight: 50,
            scrolledUnderElevation: 0,
            centerTitle: true,
            backgroundColor: ColorConst.surface,
            titleTextStyle: TextStyle(
                fontSize: 18,
                fontFamily: FontConst.metropolis,
                color: ColorConst.primary,
                fontWeight: FontWeight.w800)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 50),
                backgroundColor: ColorConst.seed,
                foregroundColor: ColorConst.onSeed,
                textStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.yellow,
                    fontWeight: FontWeight.w700,
                    fontFamily: FontConst.metropolis))),
        scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(
              ColorConst.primary,
            ),
            thickness: MaterialStateProperty.all(
              5,
            )),
        textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 24,
                color: ColorConst.textColor,
                fontWeight: FontWeight.w600),
            displayMedium: TextStyle(
                fontSize: 14,
                color: ColorConst.textColor,
                fontWeight: FontWeight.w500),
            displaySmall: TextStyle(
                fontSize: 12,
                color: ColorConst.textColor,
                fontWeight: FontWeight.w400)),
      );
}
