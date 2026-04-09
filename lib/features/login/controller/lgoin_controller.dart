import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/otp/screen/otp_screen.dart';
import 'package:pavann27/routes/app_routes.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final isLoading = false.obs;

  Future<void> continueAnonymously() async {
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your phone number",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    // Navigation to home screen after successful "login"
    Get.snackbar(
      "Success",
      "Verification code sent to +91${phoneController.text}",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Get.offAllNamed(AppRoute.otp);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}