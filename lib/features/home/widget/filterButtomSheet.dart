import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/home/widget/ally_search.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  static void show() {
    Get.bottomSheet(
      const FilterBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.55),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _gender = 'Any';
  String _ageRange = 'All';
  String _availability = 'All';

  static const List<String> _genders = ['Any', 'Female', 'Male'];
  static const List<String> _ageRanges = ['All', '20-25', '25-30', '30-35', '35+'];
  static const List<String> _availabilities = ['All', 'Online', 'Available'];

  Color _dotColor(String label) {
    if (label == 'Online') return Colors.green;
    if (label == 'Available') return Colors.orange;
    return Colors.transparent;
  }


  Widget _section({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 14.h),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // ── Title ────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Text(
              'Filters',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _section(
                  title: 'Prefer talking to',
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F5),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: _genders.map((g) {
                        final selected = _gender == g;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _gender = g),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeInOut,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: selected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                border: selected
                                    ? Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1.2,
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                g,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? AppColors.primaryColor
                                      : AppColors.subTextColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),
                _section(
                  title: 'Age range',
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F5),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: _ageRanges.map((a) {
                        final selected = _ageRange == a;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _ageRange = a),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeInOut,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: selected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                border: selected
                                    ? Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1.2,
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                a,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? AppColors.primaryColor
                                      : AppColors.subTextColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),
                _section(
                  title: 'Availability',
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F5),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: _availabilities.map((av) {
                        final selected = _availability == av;
                        final dot = _dotColor(av);
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _availability = av),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeInOut,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: selected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                border: selected
                                    ? Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1.2,
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (dot != Colors.transparent) ...[
                                    Container(
                                      width: 7.w,
                                      height: 7.w,
                                      decoration: BoxDecoration(
                                        color: dot,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                  ],
                                  Text(
                                    av,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: selected
                                          ? AppColors.primaryColor
                                          : AppColors.subTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(height: 50.h),
                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // Closes the bottom sheet
                      Get.to(() => const AllySearchScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                     child: Text(
                      'Show allies',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 66.h),
              ],
            ),
          ),
        ],
      ),
    );
  
  }
}