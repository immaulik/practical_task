import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practical_task/backend/api/api_config.dart';
import 'package:practical_task/backend/api/api_const.dart';
import 'package:practical_task/backend/api/response_model.dart';
import 'package:practical_task/models/order_history_model.dart';
import 'package:practical_task/models/product_model.dart';
import 'package:practical_task/modules/product_details/product_details.dart';
import 'package:practical_task/routes/pages.dart';
import 'package:practical_task/utils/app_utils.dart';
import 'package:practical_task/utils/dialog_utils.dart';
import 'package:practical_task/utils/logger_utils.dart';
import '../../services/storage_service/storage.dart';

class MainScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxList<OrderHistoryModel> orderList = <OrderHistoryModel>[].obs;
  RxList<OrderHistoryModel> searchList = <OrderHistoryModel>[].obs;

  RxList<OrderHistoryModel> get filterList =>
      isSearching.isTrue ? searchList : orderList;
  Rx<ResponseModel> rxApiOrderList = Rx(ResponseModel.loading());

  @override
  void onInit() {
    _getOrderHistory();
    super.onInit();
  }

  void onLogoutTap() {
    DialogUtils.showAlertBottomSheet(
      title: AppLocalizations.of(Get.context!)!.logout,
      description:
          AppLocalizations.of(Get.context!)!.are_you_sure_you_want_to_logout,
    ).then((value) {
      if (value != null && value) {
        Storage.instance.removeUser();
        Get.offAllNamed(Pages.login);
      }
    });
  }

  Future<void> _getOrderHistory() async {
    try {
      isLoading(true);
      var model = await ApiConfig.client.putData(ApiConst.orderHistory, {
        "authToken": AppUtils.userModel.authToken,
        "userId": AppUtils.userModel.userId
      });
      if (model.data["success"] == true) {
        orderList.value = ((model.data["data"] ?? []) as List<dynamic>)
            .map((e) => OrderHistoryModel.fromJson(e))
            .toList();
        rxApiOrderList.value = model;
      }
      isLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> onApiRetryTap() async {
    await _getOrderHistory();
  }

  void onSearch(String value) {
    if (value.isNotEmpty) {
      isSearching(true);
      searchList.value = orderList.where((order) {
        return order.products.any(
            (product) => product.productName.toLowerCase().startsWith(value));
      }).toList();
    } else {
      isSearching(false);
    }
  }

  void onProductTap(ProductModel productModel) {
    Get.toNamed(Pages.productDetails, arguments: productModel);
  }

  void onLanguageChange() {
    logger.d(Localizations.localeOf(Get.context!));
    if (Localizations.localeOf(Get.context!) == Locale("hi")) {
      Get.updateLocale(Locale("en"));
      Storage.instance.saveLanguage("en");
    } else {
      Get.updateLocale(Locale("hi"));
      Storage.instance.saveLanguage("hi");
    }
  }
}
