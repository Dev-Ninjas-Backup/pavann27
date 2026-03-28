// topup_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/topup/model/topup_model.dart';

class TopupController extends GetxController {
  final RxString currentBalance = "45".obs;
  final RxString selectedAmount = "399".obs;

  final RxList<QuickAddAmount> quickAmounts = [
    QuickAddAmount(amount: "39"),
    QuickAddAmount(amount: "119"),
    QuickAddAmount(amount: "249"),
    QuickAddAmount(amount: "399", isSelected: true),
    QuickAddAmount(amount: "699"),
    QuickAddAmount(amount: "999"),
    QuickAddAmount(amount: "1,499"),
    QuickAddAmount(amount: "2,499"),
    QuickAddAmount(amount: "4,999"),
  ].obs;

  final RxList<PaymentMethod> paymentMethods = [
    PaymentMethod(
      title: "UPI",
      subtitle: "PhonePe, GPay, Paytm",
      isRecommended: true,
      isSelected: true,
    ),
    PaymentMethod(
      title: "More options",
      subtitle: "Card",
      isRecommended: false,
    ),
  ].obs;

  final RxString customAmount = "".obs;

  void selectAmount(String amount) {
    selectedAmount.value = amount;
    customAmount.value = ""; // Clear custom amount when quick add is selected
  }

  void selectPaymentMethod(int index) {
    for (int i = 0; i < paymentMethods.length; i++) {
      paymentMethods[i].isSelected = (i == index);
    }
    paymentMethods.refresh();
  }

  void onContinue() {
    final amountToAdd = customAmount.value.isNotEmpty 
        ? customAmount.value 
        : selectedAmount.value;

    if (amountToAdd.isEmpty) {
      Get.snackbar("Error", "Please enter or select an amount", 
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Get.snackbar(
      "Processing",
      "Adding ₹$amountToAdd to your balance...",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Simulate success
    Future.delayed(const Duration(seconds: 2), () {
      currentBalance.value = (int.parse(currentBalance.value) + int.parse(amountToAdd.replaceAll(',', ''))).toString();
      Get.back();
      Get.snackbar("Success", "₹$amountToAdd added successfully!", 
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }
}