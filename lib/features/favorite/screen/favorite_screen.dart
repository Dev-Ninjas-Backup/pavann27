import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/favorite/controller/favorite_controller.dart';
import 'package:pavann27/features/favorite/model/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final FavoriteController controller = Get.put(FavoriteController());

  // ── Status label & color ─────────────────────────────────────────────────────
  String _statusLabel(FavoriteStatus s) {
    switch (s) {
      case FavoriteStatus.online:
        return 'Online now';
      case FavoriteStatus.onACall:
        return 'On a call';
      case FavoriteStatus.availableLater:
        return 'Available later';
      case FavoriteStatus.offline:
        return 'Offline';
    }
  }

  Color _statusColor(FavoriteStatus s) {
    switch (s) {
      case FavoriteStatus.online:
        return const Color(0xFF1DAF6B);
      case FavoriteStatus.onACall:
        return const Color(0xFFF59E0B);
      case FavoriteStatus.availableLater:
        return AppColors.subTextColor;
      case FavoriteStatus.offline:
        return AppColors.subTextColor;
    }
  }

  Color _dotColor(FavoriteStatus s) {
    switch (s) {
      case FavoriteStatus.online:
        return Colors.green;
      case FavoriteStatus.onACall:
        return Colors.orange;
      case FavoriteStatus.availableLater:
        return Colors.grey;
      case FavoriteStatus.offline:
        return Colors.grey;
    }
  }

  // ── Favorite card ────────────────────────────────────────────────────────────
  Widget _favoriteCard(FavoriteModel ally, FavoriteController ctrl) {
    final bool canTalk = ally.status == FavoriteStatus.online;
    final bool hasSession = ally.latestSessionType != null;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar with ring + status dot ──────────────────────────────────
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(2.5.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: canTalk ? AppColors.primaryColor : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28.r,
                  backgroundImage: NetworkImage(ally.image),
                  backgroundColor: AppColors.lightPurple,
                ),
              ),
              Positioned(
                bottom: 2.h,
                right: 2.w,
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: _dotColor(ally.status),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 14.w),

          // ── Info column ────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + verified badge
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        ally.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    if (ally.isVerified) ...[
                      SizedBox(width: 6.w),
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: const BoxDecoration(
                          color: AppColors.lightPurple,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified,
                          size: 13.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),

                SizedBox(height: 3.h),

                // Status
                Text(
                  _statusLabel(ally.status),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: _statusColor(ally.status),
                  ),
                ),

                SizedBox(height: 6.h),

                // Latest session OR rating/hours row
                if (hasSession)
                  Row(
                    children: [
                      Text(
                        'Latest Session:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.subTextColor,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 13.sp,
                        color: AppColors.subTextColor,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          '${ally.latestSessionType!}  ·  ${ally.latestSessionTime}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.subTextColor,
                          ),
                        ),
                      ),
                    ],
                  )
                else if (ally.rating != null)
                  Text(
                    '${ally.rating} (${ally.reviews}) · ${ally.hours}+ hrs',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(width: 10.w),

          // ── Right column: heart + action button ────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Heart
              GestureDetector(
                onTap: () => ctrl.toggleFavorite(ally.id),
                child: Icon(
                  ally.isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: ally.isFavorited
                      ? AppColors.primaryColor
                      : AppColors.subTextColor,
                  size: 22.sp,
                ),
              ),

              SizedBox(height: 12.h),

              // Talk now / Notify
              canTalk
                  ? GestureDetector(
                      onTap: () => ctrl.talkNow(ally),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'Talk now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Notify button
                        GestureDetector(
                          onTap: () => ctrl.notifyMe(ally.id),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F3F5),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.notifications_none_rounded,
                                  size: 16.sp,
                                  color: AppColors.textColor,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Notify',
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Estimated wait
                        if (ally.estimatedWait != null) ...[
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7.w,
                                height: 7.w,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                'est. ${ally.estimatedWait}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: Row(
                children: [
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
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 16.sp,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '₹45',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Title + divider ───────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(
                children: [
                  Text(
                    'Your Favorites',
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

            // ── List ─────────────────────────────────────────────────────────
            Expanded(
              child: Obx(
                () => controller.favorites.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite_border_rounded,
                              size: 52.sp,
                              color: AppColors.subTextColor,
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              'No favorites yet',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.subTextColor,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Allies you heart will appear here',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.subTextColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                        itemCount: controller.favorites.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final ally = controller.favorites[index];
                          return _favoriteCard(ally, controller);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}