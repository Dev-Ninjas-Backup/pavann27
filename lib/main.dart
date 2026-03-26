import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/bottom_navbar/controller/bottom_navbar_controller.dart';
import 'package:pavann27/features/bottom_navbar/screen/bottom_navbar_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the navigation controller so the BottomNavbarScreen can find it
  Get.put(BottomNavbarController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pavann App',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            primaryColor: const Color(0xFF7B61FF),
          ),
          builder: EasyLoading.init(),
          home: BottomNavbarScreen(),
        );
      },
    );
  }
}
