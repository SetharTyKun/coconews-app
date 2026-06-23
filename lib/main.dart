import 'package:coconews/controllers/setting_controller.dart';
import 'package:coconews/screens/setting_screen.dart';
import 'package:coconews/theme/app_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:coconews/bindings/app_bindings.dart';
import 'package:coconews/screens/discover_screen.dart';
import 'package:coconews/screens/home_screen.dart';
import 'package:coconews/screens/main_shell.dart';
import 'package:coconews/screens/bookmark_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init('article');
  await GetStorage.init('bookmark');
  await GetStorage.init('setting');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    debugPrint('isDark: ${settingController.isDark.value}');

    return GetMaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settingController.isDark.value ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MainShell()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/discover', page: () => DiscoverScreen()),
        GetPage(name: '/save', page: () => BookmarkScreen()),
        GetPage(name: '/profile', page: () => SettingScreen()),
      ],

    );
  }
}
