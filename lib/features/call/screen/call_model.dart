import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/call/controller/call_controller.dart';
import 'package:pavann27/features/call/model/call_model.dart';
import 'package:pavann27/features/chat_started/screen/chat_started_screen.dart';

class CallScreen extends StatelessWidget {
  CallScreen({super.key});

  final CallController controller = Get.put(CallController(), permanent: true);

  IconData _typeIcon(CallType t) {
    switch (t) {
      case CallType.chat:
        return Icons.chat_bubble_outline_rounded;
      case CallType.voice:
        return Icons.phone_outlined;
      case CallType.video:
        return Icons.videocam_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Obx(() {
          final call = controller.call.value;
          final bool connecting = controller.isConnecting;

          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 20.h),

                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _typeIcon(call.type),
                            size: 16.sp,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '${call.typeLabel}   ${call.formattedTime}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  Center(
                    child: SizedBox(
                      width: 220.w,
                      height: 220.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer pulse ring
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            width: controller.pulseLarge.value ? 210.w : 190.w,
                            height:
                                controller.pulseLarge.value ? 210.w : 190.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.15),
                                width: 2,
                              ),
                            ),
                          ),
                          // Inner ring
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            width: controller.pulseLarge.value ? 176.w : 164.w,
                            height:
                                controller.pulseLarge.value ? 176.w : 164.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    AppColors.primaryColor.withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                          ),
                          // Avatar
                          CircleAvatar(
                            radius: 75.r, 
                            backgroundImage: call.allyImage.startsWith('assets/')
                                ? AssetImage(call.allyImage) as ImageProvider
                                : NetworkImage(call.allyImage),
                            onBackgroundImageError: (exception, stackTrace) {
                              debugPrint('Warning: Could not load image at ${call.allyImage}');
                            },
                            // The child is shown if the backgroundImage fails to load or is null
                            child: Icon(Icons.person, size: 50.r, color: Colors.white70),
                            backgroundColor: AppColors.lightPurple,
                          ),
                          // Online dot
                          Positioned(
                            bottom: 28.h,
                            right: 28.w,
                            child: Container(
                              width: 18.w,
                              height: 18.w,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  Text(
                    call.allyName,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textColor,
                      letterSpacing: -0.5,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  _StatusDots(connecting: connecting),

                  const Spacer(),

                  Container(
                    margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    child: call.state == CallState.ringing
                        ? _RingingButtons(
                            onDecline: () {
                              controller.declineCall();
                              Get.back();
                            },
                            onAccept: () => controller.acceptCall(),
                          )
                        : connecting
                            ? _CancelButton(onTap: () {
                                controller.cancelCall();
                                Get.off(() => ChatStartedScreen());
                              })
                            : _EndCallButton(onTap: () {
                                controller.endCall();
                                Get.off(() => ChatStartedScreen());
                              }),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _RingingButtons extends StatelessWidget {
  final VoidCallback onDecline;
  final VoidCallback onAccept;

  const _RingingButtons({
    required this.onDecline,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onDecline,
              child: Container(
                width: 60.w,
                height: 60.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEBEB),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.red,
                  size: 26.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Decline',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.subTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onAccept,
              child: Container(
                width: 64.w,
                height: 64.w,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Accept',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.subTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusDots extends StatefulWidget {
  final bool connecting;
  const _StatusDots({required this.connecting});

  @override
  State<_StatusDots> createState() => _StatusDotsState();
}

class _StatusDotsState extends State<_StatusDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addListener(() {
        if (mounted) {
          setState(() {
            _dotCount = (_anim.value * 3).floor() % 4;
          });
        }
      });
    if (widget.connecting) _anim.repeat();
  }

  @override
  void didUpdateWidget(_StatusDots old) {
    super.didUpdateWidget(old);
    if (!widget.connecting) {
      _anim.stop();
    } else {
      _anim.repeat();
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String label = widget.connecting
        ? 'Connecting${'.' * _dotCount}${' ' * (3 - _dotCount)}'
        : 'Connected';

    return Text(
      label,
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColors.subTextColor,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CancelButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEB),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_rounded,
              color: Colors.red,
              size: 26.sp,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Cancel',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.subTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _EndCallButton extends StatelessWidget {
  final VoidCallback onTap;
  const _EndCallButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 64.w,
            height: 64.w,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.call_end_rounded,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'End',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.subTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}