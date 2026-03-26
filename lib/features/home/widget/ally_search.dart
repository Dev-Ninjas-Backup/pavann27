import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/home/model/ally_search_model.dart'; // Import the new model file


class AllySearchScreen extends StatefulWidget {
  const AllySearchScreen({super.key});

  @override
  State<AllySearchScreen> createState() => _AllySearchScreenState();
}

class _AllySearchScreenState extends State<AllySearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _gender = 'Any';
  String _ageRange = 'All';
  final Set<String> _languages = {'English', 'Hindi'};
  String _sortBy = 'Relevance';

  static const List<String> _genderOptions = ['Any', 'Female', 'Male'];
  static const List<String> _ageOptions = ['All', '20-25', '25-30', '30-35', '35+'];
  static const List<String> _languageOptions = ['English', 'Hindi', 'Kannada', 'Tamil', 'Telugu'];
  static const List<String> _sortOptions = ['Relevance', 'Rating', 'Sessions', 'Online first'];

 
  final List<AllySearchModel> _allies = const [
    AllySearchModel(
      name: 'Kavya',
      rating: 4.9,
      languages: ['English', 'Hindi', 'Kannada'],
      image: 'https://randomuser.me/api/portraits/women/44.jpg',
      status: AllyStatus.online,
    ),
    AllySearchModel(
      name: 'Meera',
      rating: 4.9,
      languages: ['English', 'Hindi', 'Kannada'],
      image: 'https://randomuser.me/api/portraits/women/65.jpg',
      status: AllyStatus.busy,
    ),
    AllySearchModel(
      name: 'Sara',
      rating: 4.9,
      languages: ['English', 'Hindi', 'Kannada'],
      image: 'https://randomuser.me/api/portraits/women/32.jpg',
      status: AllyStatus.offline,
    ),
    AllySearchModel(
      name: 'Nisha',
      rating: 4.9,
      languages: ['English', 'Hindi', 'Kannada'],
      image: 'https://randomuser.me/api/portraits/women/12.jpg',
      status: AllyStatus.busy,
    ),
  ];


  Color _statusBg(AllyStatus s) {
    switch (s) {
      case AllyStatus.online:
        return const Color(0xFFE6F9F0);
      case AllyStatus.busy:
        return const Color(0xFFFFF3E0);
      case AllyStatus.offline:
        return const Color(0xFFF0F0F5);
    }
  }

  Color _statusFg(AllyStatus s) {
    switch (s) {
      case AllyStatus.online:
        return const Color(0xFF1DAF6B);
      case AllyStatus.busy:
        return const Color(0xFFF59E0B);
      case AllyStatus.offline:
        return AppColors.subTextColor;
    }
  }

  String _statusLabel(AllyStatus s) {
    switch (s) {
      case AllyStatus.online:
        return 'Online';
      case AllyStatus.busy:
        return 'Busy';
      case AllyStatus.offline:
        return 'Offline';
    }
  }

  Widget _segmentedRow({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F5),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: options.map((opt) {
          final bool sel = selected == opt;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                height: 38.h,
                decoration: BoxDecoration(
                  color: sel ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                  border: sel
                      ? Border.all(color: AppColors.primaryColor, width: 1.2)
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  opt,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: sel ? AppColors.primaryColor : AppColors.subTextColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _languageChip(String lang) {
    final bool sel = _languages.contains(lang);
    return GestureDetector(
      onTap: () => setState(() {
        sel ? _languages.remove(lang) : _languages.add(lang);
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: sel ? AppColors.lightPurple : const Color(0xFFF3F3F5),
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color: sel ? AppColors.primaryColor : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Text(
          lang,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: sel ? AppColors.primaryColor : AppColors.subTextColor,
          ),
        ),
      ),
    );
  }

  Widget _sortChip(String label) {
    final bool sel = _sortBy == label;
    return GestureDetector(
      onTap: () => setState(() => _sortBy = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: sel ? AppColors.lightPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color: sel ? AppColors.primaryColor : const Color(0xFFD1D1D6),
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: sel ? AppColors.primaryColor : AppColors.subTextColor,
          ),
        ),
      ),
    );
  }

  Widget _filterCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }

  Widget _allyTile(AllySearchModel ally) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundImage: NetworkImage(ally.image),
            backgroundColor: AppColors.lightPurple,
          ),
          SizedBox(width: 14.w),

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
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                
                    SizedBox(width: 8.w),
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFFFC107), size: 16.sp),
                    SizedBox(width: 3.w),
                    Text(
                      ally.rating.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  ally.languages.join(', '),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.subTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: _statusBg(ally.status),
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(
                color: _statusFg(ally.status).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              _statusLabel(ally.status),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _statusFg(ally.status),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.subTextColor,
            size: 22.sp,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 38.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.textColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Text(
                      'Find your Ally',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textColor,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: TextField(
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.textColor,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Find your ally',
                            hintStyle: TextStyle(
                              color: AppColors.subTextColor,
                              fontSize: 15.sp,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: AppColors.subTextColor,
                              size: 20.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: 48.h,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: AppColors.textColor,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _filterCard(
                  title: 'Prefer talking to',
                  child: _segmentedRow(
                    options: _genderOptions,
                    selected: _gender,
                    onSelect: (v) => setState(() => _gender = v),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _filterCard(
                  title: 'Age range',
                  child: _segmentedRow(
                    options: _ageOptions,
                    selected: _ageRange,
                    onSelect: (v) => setState(() => _ageRange = v),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _filterCard(
                  title: 'Language',
                  child: Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: _languageOptions
                        .map((l) => _languageChip(l))
                        .toList(),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  '${_allies.length * 3} allies found',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.subTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: _sortOptions
                      .map((s) => Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: _sortChip(s),
                          ))
                      .toList(),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Your Allies',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textColor,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: _allyTile(_allies[index % _allies.length]),
                  ),
                  childCount: _allies.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}