import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/const/color_const.dart';
import 'package:practical_task/modules/login/login_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practical_task/widgets/custom_textfield.dart';
import 'package:gap/gap.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(AppLocalizations.of(context)!.helloWorld),
              Gap(50),
              Text(
                AppLocalizations.of(context)!.login,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: ColorConst.primary.withOpacity(0.8)),
              ),
              Text(
                AppLocalizations.of(context)!.enter_login_details,
                style: Get.textTheme.displayMedium,
              ),
              Gap(Get.height * 0.25),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      validatorFunction: (value) {
                        if (value != null && value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_email;
                        } else if (value != null && !GetUtils.isEmail(value)) {
                          return AppLocalizations.of(context)!.please_enter_valid_email;
                        } else {
                          return null;
                        }
                      },
                      controller: controller.emailCTRL,
                      hint: AppLocalizations.of(context)!.enter_email,
                      isBorder: false,
                      prefixBoxConstraint: const BoxConstraints(
                        minHeight: 25,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      inputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: ColorConst.primary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Obx(
                      () => CustomTextField(
                        hint: AppLocalizations.of(context)!.enter_password,
                        isBorder: false,
                        controller: controller.passwordCTRL,
                        prefixBoxConstraint: const BoxConstraints(
                          minHeight: 25,
                        ),
                        validatorFunction: (value) {
                          if (value != null && value.isEmpty) {
                            return AppLocalizations.of(context)!.please_enter_password;
                          } else if (value != null && value.length < 8) {
                            return AppLocalizations.of(context)!.password_should_be_minimum_8_character;
                          } else {
                            return null;
                          }
                        },
                        suffixBoxConstraint: const BoxConstraints(
                          minHeight: 25,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        inputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.password,
                              color: ColorConst.primary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        passwordField: !controller.visiblePasswordToggle.value,
                        suffixIcon: InkWell(
                          onTap: controller.onVisiblePasswordToggleChanged,
                          child: controller.visiblePasswordToggle.value
                              ? Icon(Icons.visibility,
                                  color: ColorConst.primary)
                              : Icon(Icons.visibility_off,
                                  color: ColorConst.primary),
                        ),
                      ),
                    ),
                    Gap(50),
                    Obx(() => controller.isLoading.isTrue
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () => controller.onLoginTap(),
                            child: Text(AppLocalizations.of(context)!.log_in))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
