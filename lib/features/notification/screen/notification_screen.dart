import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/notification/controller/notification_controller.dart';
import 'package:pavann27/features/notification/model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  // ── Icon badge config per type ───────────────────────────────────────────────
  Color _badgeBg(NotificationType t) {
    switch (t) {
      case NotificationType.milestone:
        return Colors.green;
      case NotificationType.newAlly:
        return Colors.blue;
      case NotificationType.lowBalance:
        return Colors.red;
      default:
        return AppColors.primaryColor;
    }
  }

  IconData _badgeIcon(NotificationType t) {
    switch (t) {
      case NotificationType.milestone:
        return Icons.star_outline_rounded;
      case NotificationType.newAlly:
        return Icons.person_add_alt_1_outlined;
      case NotificationType.lowBalance:
        return Icons.account_balance_wallet_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  // ── Leading widget (avatar or icon badge) ────────────────────────────────────
  Widget _leading(NotificationModel n) {
    // Avatar-based (message/ally with photo)
    if (n.avatarUrl != null) {
      final bool greyed = n.isRead && n.avatarUrl != null && n.id == '1';
      return ColorFiltered(
        colorFilter: greyed
            ? const ColorFilter.matrix([
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0,      0,      0,      1, 0,
              ])
            : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
        child: CircleAvatar(
          radius: 26.r,
          backgroundImage: NetworkImage(n.avatarUrl!),
          backgroundColor: AppColors.lightPurple,
        ),
      );
    }

    // Ghost avatar for deleted/greyed items
    if (!n.hasIconBadge) {
      return CircleAvatar(
        radius: 26.r,
        backgroundColor: Colors.grey[200],
        child: Icon(
          Icons.person_outline_rounded,
          color: Colors.grey[400],
          size: 22.sp,
        ),
      );
    }

    // Icon badge for system notifications
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: _badgeBg(n.type),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _badgeIcon(n.type),
        color: Colors.white,
        size: 24.sp,
      ),
    );
  }

  // ── Notification card ────────────────────────────────────────────────────────
  Widget _notifCard(NotificationModel n, NotificationController ctrl) {
    final bool dimmed = n.isRead;

    return Dismissible(
      key: Key(n.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEB),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: Colors.red,
          size: 22.sp,
        ),
      ),
      onDismissed: (_) => ctrl.dismiss(n.id),
      child: GestureDetector(
        onTap: () => ctrl.markAsRead(n.id),
        child: Container(
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading
              Opacity(opacity: dimmed ? 0.45 : 1.0, child: _leading(n)),

              SizedBox(width: 14.w),

              // Text block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + time row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            n.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: dimmed
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                              color: dimmed
                                  ? AppColors.subTextColor
                                  : AppColors.textColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          n.timeLabel,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.subTextColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // Body
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            n.body,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: dimmed
                                  ? AppColors.subTextColor
                                  : AppColors.textColor,
                              fontWeight: FontWeight.w400,
                              height: 1.45,
                            ),
                          ),
                        ),
                        // Unread dot
                        if (!n.isRead) ...[
                          SizedBox(width: 8.w),
                          Container(
                            width: 9.w,
                            height: 9.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Group section header ──────────────────────────────────────────────────────
  Widget _groupHeader(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, top: 4.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.subTextColor,
        ),
      ),
    );
  }

  // ── Group list builder ────────────────────────────────────────────────────────
  Widget _group(
      String label, List<NotificationModel> items, NotificationController ctrl) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _groupHeader(label),
        ...items.map(
          (n) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _notifCard(n, ctrl),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── App bar ──────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              child: Row(
                children: [
                  // Back
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textColor,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // Title
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textColor,
                      letterSpacing: -0.3,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Unread badge
                  Obx(
                    () => controller.unreadCount > 0
                        ? Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              controller.unreadCount.toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  const Spacer(),

                  // Clear all
                  GestureDetector(
                    onTap: controller.clearAll,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.lightPurple,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Clear all',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.done_all_rounded,
                            size: 16.sp,
                            color: AppColors.subTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Body ─────────────────────────────────────────────────────────
            Expanded(
              child: Obx(
                () => controller.notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              size: 52.sp,
                              color: AppColors.subTextColor,
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              'All caught up!',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.subTextColor,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'No notifications right now',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.subTextColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        padding:
                            EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
                        children: [
                          _group('Today', controller.todayItems, controller),
                          _group('Yesterday', controller.yesterdayItems,
                              controller),
                          _group('Earlier', controller.earlierItems,
                              controller),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}