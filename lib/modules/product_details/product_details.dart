
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practical_task/const/color_const.dart';
import 'package:practical_task/modules/product_details/product_details_controller.dart';
import 'package:practical_task/widgets/network_image_widget.dart';

class ProductDetails extends GetView<ProductDetailsController> {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.product),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: [
                NetworkImageWidget(
                  imgUrl: controller.pModel.value.productOtherUrl,
                  height: Get.height * 0.4,
                  width: Get.width,
                  boxFit: BoxFit.none,
                ),
                Gap(20),
                _details(),
              ],
            );
          } else {
            return Row(
              children: [
                NetworkImageWidget(
                  imgUrl: controller.pModel.value.productOtherUrl,
                  height: Get.height,
                  width: Get.width * 0.4,
                  boxFit: BoxFit.none,
                ),
                Gap(20),
                Expanded(child: SingleChildScrollView(child: _details())),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textTile(
            title: AppLocalizations.of(Get.context!)!.product_name, value: controller.pModel.value.productName),
        Gap(10),
        textTile(
            title: AppLocalizations.of(Get.context!)!.product_id,
            value: controller.pModel.value.productId.toString()),
        Gap(10),
        textTile(
            title: AppLocalizations.of(Get.context!)!.price,
            value: "\$ ${controller.pModel.value.perProductPrice}"),
        Gap(10),
        textTile(
            title: AppLocalizations.of(Get.context!)!.count,
            value: "\$ ${controller.pModel.value.productCount}",
            isLast: true),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Obx(
            () => controller.isLoading.isTrue
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () => controller.addProductToFireStore(),
                    child: controller.isLoading.isTrue
                        ? Center(
                            child: CircularProgressIndicator(
                              color: ColorConst.onSurface,
                            ),
                          )
                        : Text(AppLocalizations.of(Get.context!)!.add_product)),
          ),
        )
      ],
    );
  }

  Widget textTile(
      {required String title, required String value, bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Text(
            title,
            style: Get.textTheme.displayMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(5),
          Text(
            value,
            style: Get.textTheme.displayMedium,
          ),
          Gap(5),
          Visibility(visible: !isLast, child: Divider()),
        ],
      ),
    );
  }
}
