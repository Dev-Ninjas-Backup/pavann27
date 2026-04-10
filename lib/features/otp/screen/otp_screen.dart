import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/otp/controller/otp_controller.dart';
import 'package:pavann27/core/common/constants/iconpath.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),

                // Illustration
                Center(
                  child: Image.asset(
                    Iconpath.otpLogo,
                    height: 220.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholderIllustration(),
                  ),
                ),

                SizedBox(height: 30.h),

                // Title
                Text(
                  "Everybody needs an ally.",
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 8.h),

                // Subtitle
                Text(
                  "Allies is here when you need it.",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 32.h),

                // Progress Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: index == 1 ? 28.w : 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: index == 1
                            ? const Color(0xFF7C4DFF)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(17.r),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 30.h),

                // OTP Header
                Text(
                  "Enter your OTP",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 8.h),

                Obx(() => Text(
                      "Enter the code sent to ${controller.phoneNumber.value}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                      ),
                    )),

                SizedBox(height: 32.h),

                // OTP Input Boxes
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

                SizedBox(height: 30.h),

                // Verify Button
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C4DFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: controller.isLoading.value
                            ? SizedBox(
                                height: 24.h,
                                width: 24.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                "Verify",
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    )),

                SizedBox(height: 24.h),

                // Resend Text
                Obx(() => GestureDetector(
                      onTap: controller.canResend.value ? controller.resendOtp : null,
                      child: Text(
                        controller.resendText.isEmpty ? "Resend OTP" : controller.resendText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: controller.canResend.value
                              ? const Color(0xFF7C4DFF)
                              : Colors.grey,
                          fontWeight: controller.canResend.value
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    )),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIllustration() {
    return Container(
      height: 280.h,
      width: 280.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: const Center(
        child: Text("OTP Illustration", style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}