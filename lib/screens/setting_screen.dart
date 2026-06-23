import 'package:coconews/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Settings Title
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  'APPEARANCE',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Row(
                    children: [

                      Icon(Icons.dark_mode_outlined),

                      SizedBox(width: 10),

                      Text('Dark mode'),

                      Spacer(),

                      Transform.scale(
                        scale: 0.8,
                        child: Obx((){
                          return Switch(
                            activeColor: Colors.white,
                            activeTrackColor: Colors.blue,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Color(0xFF4A4A4A), // dark gray fill for off state
                            trackOutlineColor: WidgetStateProperty.all(Colors.transparent), // removes the border
                            value: settingController.isDark.value,
                            onChanged: (val) {
                              settingController.switchMode(val);
                            },
                          );
                        }),
                      ),


                    ],
                  ),
                )





              ],
            ),
          ),
        ),
      ),
    );
  }
}
