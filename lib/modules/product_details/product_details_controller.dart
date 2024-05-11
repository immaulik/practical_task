import 'package:get/get.dart';
import 'package:practical_task/backend/firestore/product_query.dart';
import 'package:practical_task/models/product_model.dart';
import 'package:practical_task/utils/custom_snakbar.dart';
import 'package:practical_task/utils/enum.dart';
import 'package:practical_task/utils/logger_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsController extends GetxController {
  Rx<ProductModel> pModel = ProductModel().obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    pModel.value = Get.arguments;
  }

  Future<void> addProductToFireStore() async {
    try {
      isLoading(true);
      await ProductQuery().createNotification(model: pModel.value);
      showSnackBar(
          title: AppLocalizations.of(Get.context!)!.successful,
          subTitle: AppLocalizations.of(Get.context!)!.successfully_added_to_firestore,
          type: SnackBarType.success);
      isLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      isLoading(false);
    }
  }
}
