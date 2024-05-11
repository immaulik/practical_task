import 'package:get/get.dart';
import 'package:practical_task/modules/login/login.dart';
import 'package:practical_task/modules/login/login_controller.dart';
import 'package:practical_task/modules/main_screen/main_screen.dart';
import 'package:practical_task/modules/main_screen/main_screen_controller.dart';
import 'package:practical_task/modules/product_details/product_details.dart';
import 'package:practical_task/modules/product_details/product_details_controller.dart';
import 'package:practical_task/routes/pages.dart';

abstract class Routes {
  static List<GetPage> pages = [
    GetPage(
      name: Pages.login,
      page: () => Login(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
    ),
    GetPage(
      name: Pages.mainScreen,
      page: () => MainScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => MainScreenController())),
    ),
    GetPage(
      name: Pages.productDetails,
      page: () => ProductDetails(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => ProductDetailsController())),
    ),
  ];
}
