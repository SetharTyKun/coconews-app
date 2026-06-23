import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class MainShellController extends GetxController {
  RxInt index = RxInt(0);

  void onTap(int i) {
    index(i);
  }
}