import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:practical_task/backend/api/api_config.dart';
import 'package:practical_task/backend/api/api_const.dart';
import 'package:practical_task/backend/api/enums.dart';
import 'package:practical_task/models/platform_model.dart';
import 'package:practical_task/models/user_model.dart';
import 'package:practical_task/routes/pages.dart';
import 'package:practical_task/services/storage_service/storage.dart';
import 'package:practical_task/utils/app_utils.dart';
import 'package:practical_task/utils/custom_snakbar.dart';
import 'package:practical_task/utils/enum.dart';
import 'package:practical_task/utils/logger_utils.dart';

class LoginController extends GetxController {
  final visiblePasswordToggle = false.obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailCTRL = TextEditingController();
  TextEditingController passwordCTRL = TextEditingController();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  PlatformModel platformModel = PlatformModel();

  @override
  void onInit() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    if (kDebugMode) {
      emailCTRL.text = "bhavik.patel@iottive.com";
      passwordCTRL.text = "Bhavik123#";
    }
    initPlatformState();
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onClose();
  }

  void onVisiblePasswordToggleChanged() {
    visiblePasswordToggle.value = !visiblePasswordToggle.value;
  }

  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        platformModel.phoneManufacturer = build.manufacturer;
        platformModel.phoneModel = build.model;
        platformModel.OSVersion = build.version.release;
        platformModel.platform = "Android";
      } else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        platformModel.phoneManufacturer = "Apple";
        platformModel.phoneModel = data.name;
        platformModel.OSVersion = data.utsname.version;
        platformModel.platform = "IOS";
      }
    } on PlatformException {
      logger.e("Failed to get platform version.");
    }
  }

  void onLoginTap() {
    if (formKey.currentState!.validate()) {
      _apiLogin();
    }
  }

  Future<void> _apiLogin() async {
    try {
      isLoading(true);
      var model = await ApiConfig.client.putData(ApiConst.login, {
        "phoneManufacturer": platformModel.phoneManufacturer,
        "password": passwordCTRL.text,
        "phoneModel": platformModel.phoneModel,
        "OSVersion": platformModel.OSVersion,
        "languageCode": "hi",
        "email": emailCTRL.text,
        "platform": platformModel.platform,
      });
      if (model.apiStatus == ApiStatus.success) {
        UserModel user = UserModel.fromJson(model.data);
        if (user.success) {
          Storage.instance.saveUser(user);
          AppUtils.userModel = user;
          showSnackBar(
              title: AppLocalizations.of(Get.context!)!.log_in,
              subTitle: AppLocalizations.of(Get.context!)!.login_successfully,
              type: SnackBarType.success);
          Get.offAllNamed(Pages.mainScreen);
        } else {
          showSnackBar(
              title: AppLocalizations.of(Get.context!)!.login_failed,
              subTitle: user.message,
              type: SnackBarType.error);
        }
      }
      isLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      showSnackBar(
          title: AppLocalizations.of(Get.context!)!.login_failed,
          subTitle: e.toString(),
          type: SnackBarType.error);
      isLoading(false);
    }
  }
}
