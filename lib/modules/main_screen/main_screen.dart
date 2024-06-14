import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:practical_task/backend/api/api_future.dart';
import 'package:practical_task/const/color_const.dart';
import 'package:practical_task/modules/main_screen/main_screen_controller.dart';
import 'package:practical_task/widgets/network_image_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        shape: Border(bottom: BorderSide(color: ColorConst.primary)),
        actions: [
          IconButton(
              tooltip: AppLocalizations.of(context)!.logout,
              onPressed: () => controller.onLanguageChange(),
              icon: Icon(
                Icons.g_translate,
                size: 18,
              )),
          IconButton(
              tooltip: AppLocalizations.of(context)!.logout,
              onPressed: () => controller.onLogoutTap(),
              icon: Icon(
                Icons.logout,
                size: 18,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 18, left: 18, top: 10),
        child: Column(
          children: [
            _searchField(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ApiFuture(
                rxValue: controller.rxApiOrderList,
                widget: _listView,
                onRetryTap: controller.onApiRetryTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return SizedBox(
      height: 40,
      child: TextField(
        onChanged: (value) => controller.onSearch(value),
        style: TextStyle(
          fontSize: 14,
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          filled: true,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          fillColor: ColorConst.lightBlue,
          hintText: AppLocalizations.of(Get.context!)!.search_here,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 20,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  Widget _listView() {
    return controller.filterList.isNotEmpty
        ? Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.filterList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConst.lightBlue),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.order_id} : ${controller.filterList[index].orderId}",
                              maxLines: 2,
                              style: Get.textTheme.displayMedium!
                                  .copyWith(fontSize: 12),
                            ),
                            Text(
                              "${AppLocalizations.of(context)!.date} : ${DateFormat('dd MMM, yyyy').format(controller.filterList[index].date)}",
                              maxLines: 2,
                              style: Get.textTheme.displayMedium!
                                  .copyWith(fontSize: 12),
                            ),
                            Gap(4),
                            Text(
                              "${AppLocalizations.of(context)!.amount} : ${controller.filterList[index].paidAmount}",
                              maxLines: 2,
                              style: Get.textTheme.displayMedium!
                                  .copyWith(fontSize: 12),
                            ),
                            Gap(4),
                            Text(
                              "${AppLocalizations.of(context)!.status} : ${controller.filterList[index].paymentStatus}",
                              maxLines: 2,
                              style: Get.textTheme.displayMedium!
                                  .copyWith(fontSize: 12),
                            ),
                            Gap(4),
                            Text(
                              "${AppLocalizations.of(context)!.no_of_products} : ${controller.filterList[index].products.length}",
                              maxLines: 2,
                              style: Get.textTheme.displayMedium!
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 60,
                        child: Scrollbar(
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.filterList[index].products.length,
                            itemBuilder: (context, pIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, top: 10, bottom: 10),
                                child: InkWell(
                                  onTap: () => controller.onProductTap(
                                      controller
                                          .filterList[index].products[pIndex]),
                                  child: NetworkImageWidget(
                                    imgUrl: controller.filterList[index]
                                        .products[pIndex].productOtherUrl,
                                    height: 50,
                                    width: 40,
                                    boxFit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              AppLocalizations.of(Get.context!)!.there_is_no_order,
              style: Get.textTheme.displayMedium,
            ),
          );
  }
}
