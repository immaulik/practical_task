import 'dart:ui';

import 'package:get/get.dart';
import 'package:practical_task/routes/pages.dart';
import 'package:practical_task/routes/routes.dart';
import 'package:practical_task/utils/logger_utils.dart';

import '../../models/user_model.dart';
import '../services/storage_service/storage.dart';


class AppUtils {
  AppUtils._();

  static UserModel userModel = UserModel();

  static bool get isLogin => userModel.userId != 0;
  static String initialRout = Pages.login;

  static Future<void> initDependency() async {
    /// Inject Dependency
    await Storage.instance.init();
    initialRout = await _checkLogin();
  }

  static Future<String> _checkLogin() async {
    /// Check Logged in or not
    String route = "";
    final user = await Storage.instance.getUser();
    if (user!.userId != 0) {
      userModel = user;
      final lag = await Storage.instance.getLanguage();
      if (lag != null) {
        Get.updateLocale(Locale(lag));
      }
      route = Pages.mainScreen;
    } else {
      route = Pages.login;
      Get.updateLocale(Locale("en"));
    }

    return route;
  }
}
