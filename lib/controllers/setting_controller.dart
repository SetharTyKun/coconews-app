import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


class SettingController extends GetxController {
  RxBool isDark = RxBool(false);
  RxBool notification = RxBool(false);

  final settingBox = GetStorage('setting');

  @override
  void onInit() {
    super.onInit();
    isDark.value = settingBox.read('darkMode') ?? false;
  }

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
  }

  void switchMode(bool value){
    isDark(value);

    if(value) {
      Get.changeThemeMode(ThemeMode.dark);
    }else{
      Get.changeThemeMode(ThemeMode.light);
    }

    settingBox.write('darkMode', value);
    debugPrint('isDark: $value');
  }
}