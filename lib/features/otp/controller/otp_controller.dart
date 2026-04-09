import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:pavann27/routes/app_routes.dart';

class OtpController extends GetxController {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  final RxString phoneNumber = "+91123456789".obs;
  final RxBool isLoading = false.obs;
  final RxInt timerSeconds = 25.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // Get the phone number passed from the login screen
    if (Get.arguments != null) {
      phoneNumber.value = "+91${Get.arguments}";
    }
    startTimer();
  }

  void startTimer() {
    timerSeconds.value = 25;
    canResend.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  String get resendText {
    if (canResend.value) {
      return "Resend OTP";
    } else {
      return "Resend code in 00:${timerSeconds.value.toString().padLeft(2, '0')}";
    }
  }

  void onOtpChanged(int index, String value) {
    // Move to next field if current field is filled
    if (value.length == 1 && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> verifyOtp() async {
    String otp = otpControllers.map((c) => c.text).join();

    if (otp.length != 6) {
      Get.snackbar("Error", "Please enter complete 6-digit OTP",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar("Success", "OTP Verified Successfully!",
        backgroundColor: Colors.green, colorText: Colors.white);

    Get.offAllNamed(AppRoute.success);
  }

  void resendOtp() {
    if (!canResend.value) return;

    Get.snackbar("Resent", "OTP has been resent to $phoneNumber",
        backgroundColor: Colors.green, colorText: Colors.white);

    startTimer();
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }
}