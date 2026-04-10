import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/iconpath.dart';
import 'package:pavann27/features/login/controller/lgoin_controller.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());
  final PageController _pageController = PageController();
  int currentPage = 0;
  Timer? _autoSlideTimer;

  // Add your illustration paths here
  final List<String> illustrations = [
    Iconpath.loginLogo, // First illustration// Second illustration (can be replaced with a distinct one if available)
    Iconpath.loginLogo2, // Third illustration
  ];

  final List<String> titles = [
    "Someone’s here.",
    "Talk the way you’re comfortable.",
  ];

  final List<String> subtitles = [
    "Allies connects you with a real person to talk to — one-to-one",
    "Anonymous. No judgement. End anytime.",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (currentPage < illustrations.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

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
                SizedBox(height: 30.h),

                // === Auto Changing Illustration Carousel ===
                SizedBox(
                  height: 410.h,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => currentPage = index);
                    },
                    itemCount: illustrations.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(
                            illustrations[index],
                            height: 277.h,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderIllustration(),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            titles[index],
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            subtitles[index],
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                              height: 1.45,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),

                SizedBox(height: 25.h),

                // Progress Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(illustrations.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: currentPage == index ? 28.w : 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? const Color(0xFF7C4DFF)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(17.r),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 40.h),

                // Continue Anonymously Section
                Text(
                  "Continue anonymously",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  "We use your number to verify your account",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 30.h),

                // Phone Number Field
                Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("🇮🇳", style: TextStyle(fontSize: 20.sp)),
                            SizedBox(width: 6.w),
                            Text(
                              "+91",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        indent: 10.h,
                        endIndent: 10.h,
                        width: 1,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 15.sp,
                            ),
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Continue Button
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 42.h,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.continueAnonymously(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C4DFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                        ),
                        child: controller.isLoading.value
                            ? SizedBox(
                                height: 24.h,
                                width: 24.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ))
                            : Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
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
      height: 277.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          "Illustration Here",
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        ),
      ),
    );
  }
}