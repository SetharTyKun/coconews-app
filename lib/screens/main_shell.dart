import 'package:coconews/controllers/main_shell_controller.dart';
import 'package:coconews/screens/discover_screen.dart';
import 'package:coconews/screens/home_screen.dart';
import 'package:coconews/screens/bookmark_screen.dart';
import 'package:coconews/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShell extends StatelessWidget {
  MainShell({super.key});

  final mainShellController = Get.find<MainShellController>();

  Widget? home;
  Widget? discover;
  Widget? bookmark;
  Widget? setting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx((){
        final index = mainShellController.index.value;

        if(index == 0) home ??= RepaintBoundary(child: HomeScreen());
        if(index == 1) discover ??= RepaintBoundary(child: DiscoverScreen());
        if(index == 2) bookmark ??= RepaintBoundary(child: BookmarkScreen());
        if(index == 3) setting ??= RepaintBoundary(child: SettingScreen());

        return IndexedStack(
          index: index,
          children: [
            home ?? const SizedBox.shrink(),
            discover ?? const SizedBox.shrink(),
            bookmark ?? const SizedBox.shrink(),
            setting ?? const SizedBox.shrink(),
          ],
        );

      }),

      bottomNavigationBar: Obx(() => BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        onTap: (index) => mainShellController.onTap(index),
        type: BottomNavigationBarType.fixed,
        currentIndex: mainShellController.index.value,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.explore),
            icon: Icon(Icons.explore_outlined),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
        ],
      )),
    );
  }
}