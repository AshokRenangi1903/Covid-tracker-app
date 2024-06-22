import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isLight = true.obs;
  setTheme() {
    if (isLight == true) {
      isLight.value = false;
      Get.changeTheme(ThemeData.dark());
    } else {
      isLight.value = true;
      Get.changeTheme(ThemeData.light());
    }
  }
}
