// topup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/topup/controller/topup_controller.dart';

class TopupScreen extends StatelessWidget {
  final TopupController controller = Get.put(TopupController());

  TopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
       //backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Add Balance",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.wallet, size: 30, color: Color(0xFF6C30ED)),
                  const SizedBox(height: 12),
                  Obx(() => Text(
                        "₹${controller.currentBalance.value}",
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const Text(
                    "Current balance",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Quick Add",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // Quick Add Buttons Grid
            Obx(() => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.quickAmounts.length,
                  itemBuilder: (context, index) {
                    final item = controller.quickAmounts[index];
                    final isSelected = item.amount == controller.selectedAmount.value;

                    return GestureDetector(
                      onTap: () => controller.selectAmount(item.amount),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF6C30ED) : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF6C30ED) : Colors.grey.shade300,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "₹${item.amount}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                )),

            const SizedBox(height: 24),

            const Center(
              child: Text(
                "or enter amount",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 12),

            // Custom Amount Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text("₹", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: "Enter amount",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        controller.customAmount.value = value;
                        if (value.isNotEmpty) {
                          controller.selectedAmount.value = ""; // Deselect quick amounts
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Payment Method
            const Text(
              "Payment method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Obx(() => Column(
                  children: List.generate(controller.paymentMethods.length, (index) {
                    final method = controller.paymentMethods[index];
                    return GestureDetector(
                      onTap: () => controller.selectPaymentMethod(index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: method.isSelected ? const Color(0xFF6C30ED).withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: method.isSelected ? const Color(0xFF6C30ED) : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              method.isSelected ? Icons.check_circle : Icons.circle_outlined,
                              color: method.isSelected ? const Color(0xFF6C30ED) : Colors.grey,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(method.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text(method.subtitle, style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                            const Spacer(),
                            if (method.isRecommended)
                              const Text(
                                "Recommended",
                                style: TextStyle(color: Color(0xFF6C30ED), fontWeight: FontWeight.w500),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                )),

            const SizedBox(height: 30),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: controller.onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C30ED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}