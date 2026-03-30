// topup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/iconpath.dart';
import 'package:pavann27/features/topup/controller/topup_controller.dart';

class TopupScreen extends StatelessWidget {
  final TopupController controller = Get.put(TopupController());

  TopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 22),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Add Balance",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.wallet_outlined, size: 52, color: Colors.deepPurple),
                  const SizedBox(height: 12),
                  Obx(() => Text(
                      "₹${controller.currentBalance.value}",
                      style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    )),
                  const Text("Current balance", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text("Quick Add", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            // Quick Add Grid
            Obx(() => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.35,
                  ),
                  itemCount: controller.quickAmounts.length,
                  itemBuilder: (context, index) {
                    final item = controller.quickAmounts[index];
                    return Obx(() {
                      final isSelected = item.amount == controller.selectedQuickAmount.value;
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          controller.amountController.clear();
                          controller.selectQuickAmount(item.amount);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.deepPurple : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Text(
                            "₹${item.amount}",
                            style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                )),

            const SizedBox(height: 24),
            const Center(
              child: Text("or enter amount", style: TextStyle(color: Colors.grey, fontSize: 15)),
            ),
            const SizedBox(height: 12),

            // Custom Amount Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text("₹", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller.amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        hintText: "Enter amount",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        controller.customAmount.value = value.trim();
                        if (value.isNotEmpty) {
                          controller.selectedQuickAmount.value = "";
                        } else if (value.isEmpty) {
                          controller.selectedQuickAmount.value = "399";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Payment Method
            const Text("Payment method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: Colors.deepPurple, size: 60),
                  const SizedBox(width: 14),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("UPI", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      Text("PhonePe, GPay, Paytm", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Recommended",
                      style: TextStyle(
                          color: Colors.deepPurple, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: controller.showPaymentBottomSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      ),
    );
  }
}

// ====================== Beautiful UPI Bottom Sheet ======================

class PaymentBottomSheet extends StatefulWidget {
  final String amount;

  const PaymentBottomSheet({super.key, required this.amount});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  String? selectedAppName;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 28),

              // Pay Text
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 21, color: Colors.black87),
                  children: [
                    const TextSpan(text: "Pay "),
                    TextSpan(
                      text: "₹${widget.amount}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // UPI Apps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildUpiApp("PhonePe", Iconpath.phonePe, selectedAppName == "PhonePe"),
                  _buildUpiApp("GPay", Iconpath.gPay, selectedAppName == "GPay"),
                  _buildUpiApp("Paytm", Iconpath.paytm, selectedAppName == "Paytm"),
                  _buildUpiApp("FamPay", Iconpath.famPay, selectedAppName == "FamPay"),
                ],
              ),

              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: selectedAppName == null
                      ? null
                      : () {
                          Get.back();
                          Get.snackbar(
                            "Processing",
                            "Opening $selectedAppName...",
                            backgroundColor: Colors.deepPurple,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 12,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Tap to Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpiApp(String name, String iconPath, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedAppName = name;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.deepPurple : Colors.grey.shade100,
                  width: isSelected ? 3 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(),
              child: Image.asset(
                iconPath,
                fit: BoxFit.contain,
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}