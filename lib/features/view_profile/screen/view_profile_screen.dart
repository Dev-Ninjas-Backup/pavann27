import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/view_profile/controller/view_profile_controller.dart';
import 'package:pavann27/features/view_profile/model/view_profile_model.dart';

class ViewProfileScreen extends StatelessWidget {
  ViewProfileScreen({super.key});

  final ViewProfileController controller = Get.put(ViewProfileController());

  // ── Star row ──────────────────────────────────────────────────────────────────
  Widget _stars(int count, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (i) => Icon(
          i < count ? Icons.star_rounded : Icons.star_outline_rounded,
          color: const Color(0xFFFFC107),
          size: size.sp,
        ),
      ),
    );
  }

  // ── Rating bar row ────────────────────────────────────────────────────────────
  Widget _ratingBar(int star, int count, int maxCount) {
    final double fraction = maxCount == 0 ? 0 : count / maxCount;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          // Star number
          SizedBox(
            width: 14.w,
            child: Text(
              '$star',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Icon(Icons.star_rounded,
              color: const Color(0xFFFFC107), size: 14.sp),
          SizedBox(width: 10.w),
          // Bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: 8.h,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFFFC107),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Count
          SizedBox(
            width: 28.w,
            child: Text(
              '$count',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.subTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Review card ───────────────────────────────────────────────────────────────
  Widget _reviewCard(ReviewModel r) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Anonymous avatar
              Container(
                width: 38.w,
                height: 38.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF2C2C2C),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              _stars(r.stars),
              const Spacer(),
              Text(
                r.timeLabel,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.subTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            r.text,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textColor,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // ── Floating action buttons ───────────────────────────────────────────────────
  Widget _fab({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.lightPurple, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final p = controller.profile.value;
      final rd = p.ratingBreakdown;
      final maxCount = [
        rd.fiveStar,
        rd.fourStar,
        rd.threeStar,
        rd.twoStar,
        rd.oneStar,
      ].reduce((a, b) => a > b ? a : b);

      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        // ── Floating action buttons (right side) ──────────────────────────────
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _fab(
              icon: Icons.chat_bubble_outline_rounded,
              onTap: controller.startChat,
            ),
            SizedBox(height: 12.h),
            _fab(
              icon: Icons.phone_outlined,
              onTap: controller.startVoiceCall,
            ),
            SizedBox(height: 12.h),
            _fab(
              icon: Icons.videocam_outlined,
              onTap: controller.startVideoCall,
            ),
          ],
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // ── App bar ─────────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 22.sp,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '${p.name} Profile',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Profile header ───────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 44.r,
                        backgroundImage: NetworkImage(p.imageUrl),
                        backgroundColor: AppColors.lightPurple,
                      ),
                      SizedBox(width: 16.w),
                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name + verified
                            Row(
                              children: [
                                Text(
                                  p.name,
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textColor,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                if (p.isVerified)
                                  Container(
                                    width: 22.w,
                                    height: 22.w,
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
                            ),
                            SizedBox(height: 5.h),
                            // Status
                            Row(
                              children: [
                                Container(
                                  width: 9.w,
                                  height: 9.w,
                                  decoration: BoxDecoration(
                                    color: controller.statusColor(p.status),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  controller.statusLabel(p.status),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: controller.statusColor(p.status),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            // Handle · Gender · Age
                            Text(
                              '${p.handle}  ·  ${p.gender}  ·  ${p.age}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.subTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              // ── Rating summary ────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            p.rating.toString(),
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textColor,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            '·  ${p.totalHours}+ hrs',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.subTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Based on ${p.reviewCount} reviews',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.subTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // ── About ────────────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About this Ally',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textColor,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        p.bio,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.subTextColor,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // ── Preferred Language ────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preferred Language',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: p.languages.map((lang) {
                          final bool isSelected = controller.selectedLanguages.contains(lang);
                          return GestureDetector(
                            onTap: () => controller.toggleLanguage(lang),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 9.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.lightPurple
                                    : const Color(0xFFF3F3F5),
                                borderRadius: BorderRadius.circular(50.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                  width: 1.2,
                                ),
                              ),
                              child: Text(
                                lang,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.subTextColor,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // ── Session Rates ─────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Session Rates',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(
                        () => Row(
                          children: List.generate(p.sessionRates.length, (i) {
                            final rate = p.sessionRates[i];
                            final bool sel =
                                controller.selectedRateIndex.value == i;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => controller.selectRate(i),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  margin: EdgeInsets.only(
                                      right: i < p.sessionRates.length - 1
                                          ? 10.w
                                          : 0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 14.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14.r),
                                    border: Border.all(
                                      color: sel
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      width: 1.4,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        rate.label,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: AppColors.subTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        rate.rate,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // ── Rating breakdown chart ─────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        _ratingBar(5, rd.fiveStar, maxCount),
                        _ratingBar(4, rd.fourStar, maxCount),
                        _ratingBar(3, rd.threeStar, maxCount),
                        _ratingBar(2, rd.twoStar, maxCount),
                        _ratingBar(1, rd.oneStar, maxCount),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // ── Reviews header ────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 14.h)),

              // ── Review cards ──────────────────────────────────────────────────
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _reviewCard(p.reviews[index]),
                    ),
                    childCount: p.reviews.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}