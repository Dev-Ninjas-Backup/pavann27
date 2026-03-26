import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/profile/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  // ── Reusable menu row ──────────────────────────────────────────────────────
  Widget _menuRow({
    required IconData icon,
    required String label,
    String? trailing,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              children: [
                Icon(icon, size: 22.sp, color: AppColors.textColor),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                if (trailing != null)
                  Text(
                    trailing,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.subTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color: AppColors.subTextColor,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Top bar ────────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                child: Row(
                  children: [
                    // Logo
                    const Text(
                      'allies',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    // Bell
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: AppColors.lightPurple,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.primaryColor,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    // Wallet
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 16.sp,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(width: 6.w),
                            Flexible(
                              child: Obx(
                                () => Text(
                                  controller.profile.value.walletBalance,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Title ──────────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey[200],
                      indent: 16.w,
                      endIndent: 16.w,
                    ),
                  ],
                ),
              ),

              // ── Body ───────────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [

                    // ── Anonymous user card ──────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 52.w,
                                height: 52.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.lightPurple,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.visibility_off_outlined,
                                  color: AppColors.primaryColor,
                                  size: 24.sp,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.profile.value.displayName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                      SizedBox(height: 3.h),
                                      Text(
                                        controller.profile.value.subTitle,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: AppColors.subTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Divider(height: 1, color: Colors.grey[100]),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Icon(
                                Icons.lock_outline_rounded,
                                size: 18.sp,
                                color: Colors.green,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Obx(
                                  () => Text(
                                    controller.profile.value.anonymityNote,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.subTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // ── Theme toggle ─────────────────────────────────────────
                    Obx(
                      () => Container(
                        width: double.infinity,
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            // Light Mode
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.toggleTheme(false),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  margin: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: !controller.isDarkMode.value
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.wb_sunny_outlined,
                                        size: 18.sp,
                                        color: !controller.isDarkMode.value
                                            ? Colors.white
                                            : AppColors.primaryColor,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Light Mode',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: !controller.isDarkMode.value
                                              ? Colors.white
                                              : AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Dark Mode
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.toggleTheme(true),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  margin: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: controller.isDarkMode.value
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.dark_mode_outlined,
                                        size: 18.sp,
                                        color: controller.isDarkMode.value
                                            ? Colors.white
                                            : AppColors.primaryColor,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Dark Mode',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: controller.isDarkMode.value
                                              ? Colors.white
                                              : AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // ── Main menu card ───────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          _menuRow(
                            icon: Icons.account_balance_wallet_outlined,
                            label: 'Wallet',
                            trailing: '₹45',
                            onTap: controller.openWallet,
                          ),
                          _menuRow(
                            icon: Icons.notifications_none_rounded,
                            label: 'Notifications',
                            onTap: controller.openNotifications,
                          ),
                          _menuRow(
                            icon: Icons.shield_outlined,
                            label: 'Privacy & Security',
                            onTap: controller.openPrivacySecurity,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // ── Help card ────────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: _menuRow(
                        icon: Icons.help_outline_rounded,
                        label: 'Help & Support',
                        onTap: controller.openHelpSupport,
                        isLast: true,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // ── Logout button ────────────────────────────────────────
                    GestureDetector(
                      onTap: controller.logout,
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF0F0),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.35),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // ── Delete account ───────────────────────────────────────
                    GestureDetector(
                      onTap: controller.deleteAccount,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Delete Account',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}