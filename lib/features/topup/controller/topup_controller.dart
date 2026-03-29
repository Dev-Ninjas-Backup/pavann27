// topup_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pavann27/features/topup/model/topup_model.dart';
import 'package:pavann27/features/topup/screen/topup_screen.dart';

class TopupController extends GetxController {
  final RxString currentBalance = "45".obs;
  final RxString selectedQuickAmount = "399".obs;
  final RxString customAmount = "".obs;

  final TextEditingController amountController = TextEditingController();

  final RxList<QuickAddAmount> quickAmounts = [
    QuickAddAmount(amount: "100"),
    QuickAddAmount(amount: "200"),
    QuickAddAmount(amount: "399"),
    QuickAddAmount(amount: "500"),
    QuickAddAmount(amount: "1000"),
    QuickAddAmount(amount: "2000"),
  ].obs;

  String get amountToPay => customAmount.value.isNotEmpty ? customAmount.value : selectedQuickAmount.value;

  void selectQuickAmount(String amount) {
    selectedQuickAmount.value = amount;
    customAmount.value = "";
    amountController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void showPaymentBottomSheet() {
    final payAmount = amountToPay;

    if (payAmount.isEmpty) {
      Get.snackbar("Error", "Please select or enter an amount",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    Get.bottomSheet(
      PaymentBottomSheet(amount: payAmount),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.75),
      enableDrag: true,
    );
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}