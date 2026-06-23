import 'package:coconews/controllers/bookmark_controller.dart';
import 'package:coconews/controllers/connectivity_controller.dart';
import 'package:coconews/controllers/discover_controller.dart';
import 'package:coconews/controllers/home_controller.dart';
import 'package:coconews/controllers/main_shell_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(ConnectivityController());
    Get.lazyPut(() => MainShellController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DiscoverController());
    Get.lazyPut(() => BookmarkController());
  }
}