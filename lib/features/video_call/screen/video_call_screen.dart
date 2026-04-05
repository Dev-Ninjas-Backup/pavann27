import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/video_call/controller/video_call_controller.dart';

class VideoCallScreen extends StatelessWidget {
  VideoCallScreen({super.key});

  final VideoCallController controller = Get.put(VideoCallController());

  // ── Control button ────────────────────────────────────────────────────────────
  Widget _controlBtn({
    required IconData icon,
    required VoidCallback onTap,
    bool isRed = false,
    bool isActive = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: isRed ? Colors.red : const Color(0xFFF3F3F5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isRed
              ? Colors.white
              : isActive
                  ? AppColors.textColor
                  : AppColors.subTextColor,
          size: 26.sp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Obx(() {
          final call = controller.call.value;
          final bool connecting = controller.isConnecting;

          return Stack(
            children: [
              // ─────────────────────────────────────────────────────────────
              //  MAIN LAYOUT
              // ─────────────────────────────────────────────────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top bar ───────────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                    child: Row(
                      children: [
                        // Timer pill
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            call.formattedTime,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Report button
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.flag_outlined,
                                size: 16.sp,
                                color: AppColors.subTextColor,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Report',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.subTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // More options
                        Icon(
                          Icons.more_vert_rounded,
                          color: AppColors.subTextColor,
                          size: 22.sp,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // ── "Tap to move preview" hint ────────────────────────────
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      'Tap to move preview',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.subTextColor,
                      ),
                    ),
                  ),

                  // ── Ally avatar + connecting ───────────────────────────────
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Pulsing ring + avatar
                          SizedBox(
                            width: 200.w,
                            height: 200.w,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Outer pulse ring
                                AnimatedContainer(
                                  duration:
                                      const Duration(milliseconds: 900),
                                  curve: Curves.easeInOut,
                                  width: connecting
                                      ? (controller.pulseLarge.value
                                          ? 196.w
                                          : 178.w)
                                      : 178.w,
                                  height: connecting
                                      ? (controller.pulseLarge.value
                                          ? 196.w
                                          : 178.w)
                                      : 178.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.18),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                // Inner ring
                                AnimatedContainer(
                                  duration:
                                      const Duration(milliseconds: 900),
                                  curve: Curves.easeInOut,
                                  width: connecting
                                      ? (controller.pulseLarge.value
                                          ? 166.w
                                          : 154.w)
                                      : 154.w,
                                  height: connecting
                                      ? (controller.pulseLarge.value
                                          ? 166.w
                                          : 154.w)
                                      : 154.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.28),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                // Avatar
                                CircleAvatar(
                                  radius: 70.r,
                                  backgroundImage:
                                      NetworkImage(call.allyImage),
                                  backgroundColor: AppColors.lightPurple,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Connecting / Connected status
                          _ConnectingDots(connecting: connecting),
                        ],
                      ),
                    ),
                  ),

                  // ── Ally name ─────────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 0, 14.h),
                    child: Text(
                      call.allyName,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textColor,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),

                  // ── Control bar ───────────────────────────────────────────
                  Container(
                    margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w, vertical: 18.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Mic toggle
                        _controlBtn(
                          icon: call.isMicOn
                              ? Icons.mic_outlined
                              : Icons.mic_off_outlined,
                          onTap: controller.toggleMic,
                          isActive: call.isMicOn,
                        ),
                        // Camera toggle
                        _controlBtn(
                          icon: call.isCameraOn
                              ? Icons.videocam_outlined
                              : Icons.videocam_off_outlined,
                          onTap: controller.toggleCamera,
                          isActive: call.isCameraOn,
                        ),
                        // End call (red centre)
                        _controlBtn(
                          icon: Icons.call_end_rounded,
                          onTap: controller.endCall,
                          isRed: true,
                        ),
                        // Flip camera
                        _controlBtn(
                          icon: Icons.flip_camera_ios_outlined,
                          onTap: controller.flipCamera,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // ── Footer note ───────────────────────────────────────────
                  Center(
                    child: Text(
                      'End anytime  ·  Anonymous',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.subTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),
                ],
              ),

              // ─────────────────────────────────────────────────────────────
              //  DRAGGABLE SELF-PREVIEW (top right)
              // ─────────────────────────────────────────────────────────────
              Positioned(
                top: 60.h + controller.previewOffset.value.dy,
                right: 16.w - controller.previewOffset.value.dx,
                child: GestureDetector(
                  onPanUpdate: (d) =>
                      controller.updatePreviewOffset(d.delta),
                  child: Container(
                    width: 110.w,
                    height: 148.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Stack(
                      children: [
                        // Expand icon
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: Icon(
                            Icons.open_in_full_rounded,
                            size: 16.sp,
                            color: AppColors.subTextColor,
                          ),
                        ),
                        // "You" label
                        Center(
                          child: Text(
                            'You',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.subTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ── Animated "Connecting..." dots ─────────────────────────────────────────────
class _ConnectingDots extends StatefulWidget {
  final bool connecting;
  const _ConnectingDots({required this.connecting});

  @override
  State<_ConnectingDots> createState() => _ConnectingDotsState();
}

class _ConnectingDotsState extends State<_ConnectingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  int _dotCount = 3;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
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
  void didUpdateWidget(_ConnectingDots old) {
    super.didUpdateWidget(old);
    widget.connecting ? _anim.repeat() : _anim.stop();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String text = widget.connecting
        ? 'Connecting${'.' * _dotCount}${' ' * (3 - _dotCount)}'
        : 'Connected';
    return Text(
      text,
      style: TextStyle(
        fontSize: 15.sp,
        color: AppColors.subTextColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}