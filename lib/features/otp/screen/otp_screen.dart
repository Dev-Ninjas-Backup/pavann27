import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/otp/controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  final OtpController controller = Get.put(OtpController());

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Logo
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B46C1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.chat_bubble_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Avatars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAvatar(false),
                  const SizedBox(width: 20),
                  _buildAvatar(true),
                ],
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                "Someone's here.",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Allies connects you with a real person to talk to — one-to-one",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == 1 ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == 1
                          ? const Color(0xFF6B46C1)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 50),

              // OTP Section
              const Text(
                "Enter your OTP",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                    "Enter the code sent to ${controller.phoneNumber.value}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  )),

              const SizedBox(height: 32),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    height: 60,
                    child: TextField(
                      autofocus: index == 0,
                      controller: controller.otpControllers[index],
                      focusNode: controller.focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: const TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF6B46C1),
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) => controller.onOtpChanged(index, value),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Verify Button
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B46C1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Verify",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  )),

              const SizedBox(height: 24),

              // Resend Timer
              Obx(
                () => GestureDetector(
                  onTap: controller.canResend.value ? controller.resendOtp : null,
                  child: Text(
                    controller.resendText, // Access the getter directly
                    style: TextStyle(
                      fontSize: 15,
                      color: controller.canResend.value ? const Color(0xFF6B46C1) : Colors.grey,
                      fontWeight: controller.canResend.value ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // The rest of your existing code...
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(bool isSpecial) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFE0D4FF),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.person,
          size: 40,
          color: const Color(0xFF6B46C1),
        ),
      ),
    );
  }
}