import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavann27/features/home/controller/home_page_controller.dart';
import 'package:pavann27/features/home/model/home_page_model.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';

class AllyCard extends StatelessWidget {
  final HomePageModel ally;
  final bool isHighlighted;
  final VoidCallback onTalkTap;
  final VoidCallback onCardTap;
  final HomePageController controller;

  const AllyCard({
    super.key,
    required this.ally,
    required this.isHighlighted,
    required this.onTalkTap,
    required this.onCardTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 360.w,
        constraints: BoxConstraints(minHeight: 130.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isHighlighted
              ? AppColors.lightPurple.withOpacity(0.35)
              : AppColors.cardColor,
          borderRadius: BorderRadius.circular(24.r),
          border: isHighlighted
              ? Border.all(color: AppColors.primaryColor, width: 1.4)
              : Border.all(color: Colors.transparent, width: 1.4),
          boxShadow: isHighlighted
              ? [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.12),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ally.canTalkNow
                          ? AppColors.primaryColor
                          : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 24.r,
                    backgroundImage: NetworkImage(ally.image),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 2.h,
                  child: Container(
                    height: 16.w,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: controller.getStatusColor(ally.status),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 18.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          ally.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                      if (ally.isVerified) ...[
                        SizedBox(width: 6.w),
                        Container(
                          height: 20.w,
                          width: 20.w,
                          decoration: const BoxDecoration(
                            color: AppColors.lightPurple,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified,
                            size: 14.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    '${ally.age} y',
                    style: TextStyle(
                      color: AppColors.subTextColor,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Container(
                        height: 8.w,
                        width: 8.w,
                        decoration: BoxDecoration(
                          color: controller.getStatusColor(ally.status),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          ally.status,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: controller.getStatusColor(ally.status),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${ally.rating} (${ally.reviews}) · ${ally.hours}+ hrs',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    ally.bio,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF6F6F75),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ally.canTalkNow
                    ? GestureDetector(
                        onTap: () {
                          // Ensure the card is selected before initiating the action.
                          // This prevents toggling it off if it's already selected.
                          if (!isHighlighted) {
                            onCardTap();
                          }
                          onTalkTap();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppColors.primaryColor.withOpacity(0.25),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            'Talk now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          // Ensure the card is selected when tapping the action.
                          // This is more intuitive than toggling.
                          if (!isHighlighted) {
                            onCardTap();
                          }
                          // NOTE: Notify-specific logic could be added here.
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F5),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications_none_rounded,
                                size: 18.sp,
                                color: AppColors.textColor,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Notify',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                if (ally.estimatedTime != null) ...[
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Container(
                        height: 8.w,
                        width: 8.w,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        ally.estimatedTime!,
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}