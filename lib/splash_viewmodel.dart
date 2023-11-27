import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_cares_app/uilayer/bottom_nav.dart';

class SplashScreenViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(
        Duration(seconds: 5),
        () => Get.offAll(BottomNav(),
            duration:
                Duration(seconds: 1), //duration of transitions, default 1 sec
            transition: Transition.rightToLeft));
  }
}
