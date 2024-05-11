
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/utils/enum.dart';

extension SizeConfig on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * Get.height / 100;

  int get hi => this * Get.height ~/ 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => this * Get.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => this * (Get.width / 3) / 100;
}

extension SnackBarExtension on SnackBarType {
  Color get color {
    switch (this) {
      case SnackBarType.error:
        return Color(0xFFF05252);
      case SnackBarType.success:
        return Color(0xFF0E9F6E);
      case SnackBarType.general:
        return Color(0xFFD9896A);
    }
  }
}
