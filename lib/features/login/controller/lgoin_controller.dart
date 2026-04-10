import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final isLoading = false.obs;

  Future<void> continueAnonymously() async {
    String phone = phoneController.text.trim();

    if (phone.isEmpty) {
      Get.snackbar("Error", "Please enter your phone number",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    if (phone.length < 10) {
      Get.snackbar("Error", "Please enter a valid phone number",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;

    // Navigate to OTP Screen
    Get.toNamed('/otp', arguments: phone);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}