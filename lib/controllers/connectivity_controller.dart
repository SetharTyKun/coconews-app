import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ConnectivityController extends GetxController {
  RxBool isOnline = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    checkConnection();
  }

  Future<void> checkConnection() async {
    final result = await Connectivity().checkConnectivity();

    if(result.contains(ConnectivityResult.none)){
      debugPrint('The connection is Offline');
      return;
    }

    isOnline(true);
    debugPrint('The connection is Online');
  }

}