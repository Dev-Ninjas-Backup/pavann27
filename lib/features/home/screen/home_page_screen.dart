import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/home/controller/home_page_controller.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/home/widget/ally_card.dart';
import 'package:pavann27/features/chat/screen/chat_screen.dart';
import 'package:pavann27/features/home/widget/connecting_dialog.dart';
import 'package:pavann27/features/home/widget/filterButtomSheet.dart';
import 'package:pavann27/features/notification/screen/notification_screen.dart';
import 'package:pavann27/features/story/screen/story_screen.dart';
import 'package:pavann27/features/topup/screen/topup_screen.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(7.5.w, 16.h, 7.5.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              SizedBox(height: 24.h),
              _buildStorySection(),
              SizedBox(height: 28.h),
              _buildRecentSection(),
              SizedBox(height: 24.h),
              _buildSearchBar(),
              SizedBox(height: 28.h),
              Text(
                'Discover',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => ListView.separated(
                  itemCount: controller.filteredAllies.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => SizedBox(height: 18.h),
                  itemBuilder: (context, index) {
                    final ally = controller.filteredAllies[index];
                    return AllyCard(
                      ally: ally,
                      isHighlighted: controller.selectedAllies.contains(ally.name),
                      controller: controller,
                      onCardTap: () => Get.to(() => ChatScreen(), arguments: {
                        'id': ally.name, // Using name as ID if ID is missing in model
                        'name': ally.name,
                        'image': ally.image,
                        'isVerified': ally.isVerified,
                      }),
                      onTalkTap: () => Get.dialog(
                        ConnectingDialog(ally: ally),
                        barrierDismissible: true,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  TOP BAR
  // ─────────────────────────────────────────────
  Widget _buildTopBar() {
    return Row(
      children: [
        const Text(
          'allies',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.textColor,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Get.to(() => NotificationScreen()),
          child: Container(
            height: 38.w,
            width: 38.w,
            decoration: const BoxDecoration(
              color: AppColors.lightPurple,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        GestureDetector(
          onTap: () => Get.to(() => TopupScreen()),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.lightPurple,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 18.sp,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  '₹45',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  STORY SECTION
  // ─────────────────────────────────────────────
  Widget _buildStorySection() {
    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.topAllies.length,
        separatorBuilder: (_, __) => SizedBox(width: 22.w),
        itemBuilder: (context, index) {
          final item = controller.topAllies[index];
          return GestureDetector(
            onTap: () => Get.to(() => StoryScreen(), arguments: {
              'id': item['id'] ?? index.toString(),
              'name': item['name'],
              'image': item['image'],
            }),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 28.r,
                    backgroundImage: (item['image']!.startsWith('http')
                        ? NetworkImage(item['image']!)
                        : AssetImage(item['image']!)) as ImageProvider,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  item['name']!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  RECENT SECTION
  // ─────────────────────────────────────────────
  Widget _buildRecentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 42.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.recentImages.length,
            itemBuilder: (context, index) {
              final dotColor = index % 3 == 0
                  ? Colors.green
                  : index % 2 == 0
                      ? Colors.orange
                      : Colors.amber;

              return Transform.translate(
                offset: Offset(index == 0 ? 0 : -12.w * index, 0),
                child: GestureDetector(
                  onTap: () => Get.to(() => ChatScreen(), arguments: {
                    'id': index.toString(),
                    'name': 'Recent Ally',
                    'image': controller.recentImages[index],
                    'isVerified': false,
                  }),
                  child: SizedBox(
                    width: 58.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 26.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 24.r,
                            backgroundImage: (controller.recentImages[index].startsWith('http')
                                ? NetworkImage(controller.recentImages[index])
                                : AssetImage(controller.recentImages[index])) as ImageProvider,
                          ),
                        ),
                        Positioned(
                          bottom: 2.h,
                          right: 2.w,
                          child: Container(
                            height: 14.w,
                            width: 14.w,
                            decoration: BoxDecoration(
                              color: dotColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  SEARCH BAR
  // ─────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: TextField(
              controller: controller.searchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Find your ally',
                hintStyle: TextStyle(
                  color: const Color(0xFF9A9AA0),
                  fontSize: 16.sp,
                ),
                prefixIcon: const Icon(Icons.search, color: AppColors.textColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () => FilterBottomSheet.show(),
          child: Container(
            height: 42.h,
            width: 42.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }
}