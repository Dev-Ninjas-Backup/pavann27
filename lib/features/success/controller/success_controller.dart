import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/routes/app_routes.dart';

class SuccessController extends GetxController {
  void findAnAlly() {
    Get.snackbar(
      "Finding Ally",
      "Looking for someone to talk to...",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );

    // Navigate to BottomNavbarScreen (Home)
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.offAllNamed(AppRoute.home);
    });
  }
}