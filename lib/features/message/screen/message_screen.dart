import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/message/controller/message_controller.dart';
import 'package:pavann27/features/message/model/message_model.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final MessageController controller = Get.put(MessageController());

  // ── Single inbox row ─────────────────────────────────────────────────────────
  Widget _inboxRow(MessageModel msg, MessageController ctrl) {
    final bool isMissedCall = msg.lastMessage.toLowerCase() == 'missed call';

    return InkWell(
      onTap: () => ctrl.openConversation(msg),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: [
            // ── Avatar + online dot ──────────────────────────────────────────
            Stack(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage(msg.image),
                  backgroundColor: AppColors.lightPurple,
                ),
                if (msg.isOnline)
                  Positioned(
                    bottom: 1.h,
                    right: 1.w,
                    child: Container(
                      width: 13.w,
                      height: 13.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(width: 14.w),

            // ── Name + preview ───────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name row
                  Row(
                    children: [
                      Text(
                        msg.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: msg.isUnread
                              ? FontWeight.w800
                              : FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                      ),
                      if (msg.isVerified) ...[
                        SizedBox(width: 6.w),
                        Container(
                          width: 19.w,
                          height: 19.w,
                          decoration: const BoxDecoration(
                            color: AppColors.lightPurple,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified,
                            size: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // Last message preview
                  Row(
                    children: [
                      if (isMissedCall) ...[
                        Icon(
                          Icons.call_missed_rounded,
                          size: 13.sp,
                          color: Colors.red,
                        ),
                        SizedBox(width: 4.w),
                      ],
                      Text(
                        msg.lastMessage,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isMissedCall
                              ? Colors.red
                              : AppColors.subTextColor,
                          fontWeight: msg.isUnread
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 10.w),

            // ── Time + chevron ───────────────────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  msg.timeLabel,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.subTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 6.h),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color: AppColors.subTextColor,
                ),
              ],
            ),
          ],
        ),
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
                    'Inbox',
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

            // ── Message list ──────────────────────────────────────────────────
            Expanded(
              child: Obx(
                () => controller.messages.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 52.sp,
                              color: AppColors.subTextColor,
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              'No messages yet',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.subTextColor,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Your conversations will appear here',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.subTextColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: controller.messages.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey[150] ?? Colors.grey[200]!,
                        ),
                        itemBuilder: (context, index) {
                          final msg = controller.messages[index];
                          return Dismissible(
                            key: Key(msg.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20.w),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.red,
                                size: 22.sp,
                              ),
                            ),
                            onDismissed: (_) =>
                                controller.deleteConversation(msg.id),
                            child: _inboxRow(msg, controller),
                          );
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