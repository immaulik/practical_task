import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/utils/enum.dart';
import 'package:practical_task/utils/extension.dart';

void showSnackBar(
    {required String title,
    required String subTitle,
    required SnackBarType type}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x19000000),
                spreadRadius: 2.0,
                blurRadius: 8.0,
                offset: Offset(2, 4),
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: type.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                subTitle,
                style: Get.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: type.color,
                ),
              ),
            ],
          )),
    ),
  );
}
