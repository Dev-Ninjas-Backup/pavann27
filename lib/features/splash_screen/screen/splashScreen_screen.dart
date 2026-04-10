import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/iconpath.dart';
import 'package:pavann27/features/splash_screen/controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashScreenController controller = Get.put(SplashScreenController());

  static const Color _bg = Color(0xFF6C30ED);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: _bg,
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeOut,
            opacity: controller.opacity.value,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeOut,
              scale: controller.scale.value,
              child: SizedBox(
                width: 100.w,
                height: 100.w,
                child: Image.asset(
                  Iconpath.splashLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

