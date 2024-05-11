import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:practical_task/const/color_const.dart';
import 'package:practical_task/utils/extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogUtils {
  DialogUtils.__();

  static Future<bool?> showAlertBottomSheet({
    required String title,
    String description = "",
  }) {
    return Get.bottomSheet<bool>(
        _AlertBottomSheet(
          title: title,
          description: description,
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: true,
        enterBottomSheetDuration: const Duration(milliseconds: 300),
        exitBottomSheetDuration: const Duration(milliseconds: 300),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ));
  }
}

class _AlertBottomSheet extends StatelessWidget {
  final String title;
  final String description;

  const _AlertBottomSheet({
    super.key,
    required this.title,
    this.description = "",
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 3.h),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  SizedBox(height: 3.h),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Get.back(result: true);
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: ColorConst.seed)),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.yes,
                            style: TextStyle(
                              color: ColorConst.seed,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Get.back(result: false);
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: ColorConst.seed,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.no,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    )
                  ],
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
