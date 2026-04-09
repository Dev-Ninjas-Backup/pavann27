import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/routes/app_routes.dart';
import 'package:pavann27/core/binding/initial_binding.dart';
import 'package:pavann27/core/common/constants/app_theme.dart';

/// Main application widget
/// Configures theme, routing, and global settings
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          
          // Routing Configuration
          initialRoute: AppRoute.splashScreen,
          getPages: AppRoute.routes,
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 300),
          
          // Theme Configuration
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          
          // Global Builders
          builder: EasyLoading.init(),
          
          // Dependency Injection
          initialBinding: InitialBinding(),
        );
      },
    );
  }
}
