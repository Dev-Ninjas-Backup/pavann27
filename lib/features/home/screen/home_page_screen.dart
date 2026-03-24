import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/home/controller/home_page_controller.dart';
import 'package:pavann27/features/home/model/home_page_model.dart';


class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  final HomePageController controller = Get.put(HomePageController());

  static const Color primaryColor = Color(0xFF7C3AED);
  static const Color lightPurple = Color(0xFFEDE9FE);
  static const Color backgroundColor = Color(0xFFF4F4F6);
  static const Color textColor = Color(0xFF111111);
  static const Color subTextColor = Color(0xFF8E8E93);
  static const Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: _buildBottomNavBar(),
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
                  color: textColor,
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
                    return _buildAllyCard(ally, index == 0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        const Text(
          'allies',
          style: TextStyle(
            fontSize: 28, // Often titles are kept larger or use .sp carefully
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        Container(
          height: 46.w,
          width: 46.w,
          decoration: const BoxDecoration(
            color: lightPurple,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: primaryColor,
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: lightPurple,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 18.sp,
                color: primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                '₹45',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStorySection() {
    return SizedBox(
      height: 96.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.topAllies.length,
        separatorBuilder: (_, __) => SizedBox(width: 22.w),
        itemBuilder: (context, index) {
          final item = controller.topAllies[index];
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(2.5.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor, width: 2),
                ),
                child: CircleAvatar(
                  radius: 28.r,
                  backgroundImage: NetworkImage(item['image']!),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                item['name']!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 58.h,
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
                child: SizedBox(
                  width: 58.h, // Keeping square aspect ratio related to height
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 26.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 24.r,
                          backgroundImage:
                              NetworkImage(controller.recentImages[index]),
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
              );
            },
          ),
        ),
      ],
    );
  }

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
                prefixIcon: const Icon(Icons.search, color: textColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          height: 58.h,
          width: 58.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: const Icon(
            Icons.tune_rounded,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAllyCard(HomePageModel ally, bool isHighlighted) {
    return Container(
      width: 360.w,
      height: 130.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24.r),
        border: isHighlighted
            ? Border.all(color: primaryColor, width: 1.4)
            : null,
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: primaryColor.withOpacity(0.12),
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
                    color: ally.canTalkNow ? primaryColor : Colors.grey,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 16,
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
                    Text(
                      ally.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    if (ally.isVerified) ...[
                      SizedBox(width: 6.w),
                      Container(
                        height: 20.w,
                        width: 20.w,
                        decoration: const BoxDecoration(
                          color: lightPurple,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified,
                          size: 14.sp,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  '${ally.age} y',
                  style: TextStyle(
                    color: subTextColor,
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
                    color: textColor,
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
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.25),
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
                    )
                  : Container(
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
                            color: textColor,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Notify',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
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
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, true),
          _navItem(Icons.favorite_border_rounded, false),
          _navItem(Icons.chat_bubble_outline_rounded, false),
          _navItem(Icons.person_outline_rounded, false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, bool isSelected) {
    return Expanded(
      child: Container(
        height: 46.h,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : textColor,
        ),
      ),
    );
  }
}