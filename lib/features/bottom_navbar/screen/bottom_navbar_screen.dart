import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/bottom_navbar/controller/bottom_navbar_controller.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/favorite/screen/favorite_screen.dart';
import 'package:pavann27/features/home/screen/home_screen.dart';
import 'package:pavann27/features/message/screen/message_screen.dart';
import 'package:pavann27/features/profile/screen/profile_screen.dart';

class BottomNavbarScreen extends StatelessWidget {
  BottomNavbarScreen({super.key});

  final BottomNavbarController controller = Get.find<BottomNavbarController>();

  final List<Widget> _screens = [
    HomePageScreen(),
    FavoriteScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: _screens,
        ),
      ),
      bottomNavigationBar: _buildBottomNavbar(),
    );
  }

  Widget _buildBottomNavbar() {
    return Obx(
      () => SafeArea(
        child: Container(
          height: 68.h,
          margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(34.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(controller.icons.length, (index) {
              final bool isSelected = controller.currentIndex.value == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeIndex(index),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: 30.h,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(
                        controller.icons[index],
                        size: 20.sp,
                        color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}