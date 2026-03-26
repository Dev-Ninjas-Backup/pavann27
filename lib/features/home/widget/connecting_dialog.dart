import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/home/model/home_page_model.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/core/common/constants/widget/custom_button.dart';

class ConnectingDialog extends StatelessWidget {
  final HomePageModel ally;

  const ConnectingDialog({super.key, required this.ally});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ───────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 14.h),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryColor, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 22.r,
                          backgroundImage: NetworkImage(ally.image),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ally.name,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
                        ),
                        Text(
                          'Available now',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 18.sp,
                        color: AppColors.subTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, thickness: 1, color: Colors.grey[100]),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 60.w, 12.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                          bottomLeft: Radius.circular(4.r),
                        ),
                      ),
                      child: Text(
                        '"${ally.bio}"',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Just now',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.subTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildInputBar(messageController),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 28.h),
              child: CustomButton(
                text: 'Start chatting',
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar(TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Say hi...',
                  hintStyle: TextStyle(
                    color: AppColors.subTextColor,
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () {
                  log('Message: ${controller.text}');
                },
                child: Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}