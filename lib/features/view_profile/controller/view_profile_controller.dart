import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/widget/app_colors.dart';
import 'package:pavann27/features/chat/screen/chat_screen.dart';
import 'package:pavann27/features/view_profile/model/view_profile_model.dart';

class ViewProfileController extends GetxController {
  // ── Selected session type (Chat / Voice Call / Video Call) ───────────────────
  final RxInt selectedRateIndex = 0.obs;

  final RxList<String> selectedLanguages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (profile.value.languages.isNotEmpty) {
      selectedLanguages.add(profile.value.languages.first);
    }
  }

  // ── Profile data (pass via constructor or fetch from API) ────────────────────
  final Rx<ViewProfileModel> profile = const ViewProfileModel(
    id: '1',
    name: 'Amyra',
    imageUrl: 'https://randomuser.me/api/portraits/women/12.jpg',
    isVerified: true,
    status: AllyOnlineStatus.online,
    handle: '@aliya9',
    gender: 'Female',
    age: '20 Years',
    rating: 4.8,
    totalHours: 410,
    reviewCount: 198,
    bio:
        'I went through a confusing phase in college and learned how much it helps to talk freely. During that time, I realized the power of having someone who just listens without judgment.',
    languages: ['English', 'Hindi', 'Kannada'],
    sessionRates: [
      SessionRate(label: 'Chat', rate: '₹8/m'),
      SessionRate(label: 'Voice Call', rate: '₹12/m'),
      SessionRate(label: 'Video Call', rate: '₹22/m'),
    ],
    ratingBreakdown: RatingBreakdown(
      fiveStar: 150,
      fourStar: 150,
      threeStar: 150,
      twoStar: 150,
      oneStar: 150,
    ),
    reviews: [
      ReviewModel(
        id: 'r1',
        stars: 5,
        text:
            '" She listened patiently and didn\'t rush the call. Made me feel truly heard. "',
        timeLabel: 'Yesterday',
      ),
      ReviewModel(
        id: 'r2',
        stars: 5,
        text:
            '" Very understanding and made me feel comfortable opening up about my issues. "',
        timeLabel: '2 days Ago',
      ),
      ReviewModel(
        id: 'r3',
        stars: 5,
        text:
            '" Helped me see things from a different perspective. Really insightful conversation. "',
        timeLabel: '5 days Ago',
      ),
    ],
  ).obs;

  // ── Select session rate tab ───────────────────────────────────────────────────
  void selectRate(int index) => selectedRateIndex.value = index;

  void toggleLanguage(String lang) {
    if (selectedLanguages.contains(lang)) {
      selectedLanguages.remove(lang);
    } else {
      selectedLanguages.add(lang);
    }
  }

  // ── Action: start chat ────────────────────────────────────────────────────────
  void startChat() {
    // TODO: Get.toNamed('/chat', arguments: profile.value);
    final p = profile.value;
    Get.to(() => ChatScreen(), arguments: {
      'id': p.id,
      'name': p.name,
      'image': p.imageUrl,
      'isVerified': p.isVerified,
    });
  }

  // ── Action: voice call ────────────────────────────────────────────────────────
  void startVoiceCall() {
    // TODO: Get.toNamed('/voice-call', arguments: profile.value);
  }

  // ── Action: video call ────────────────────────────────────────────────────────
  void startVideoCall() {
    // TODO: Get.toNamed('/video-call', arguments: profile.value);
  }

  // ── Status helpers ────────────────────────────────────────────────────────────
  String statusLabel(AllyOnlineStatus s) {
    switch (s) {
      case AllyOnlineStatus.online:
        return 'Online';
      case AllyOnlineStatus.busy:
        return 'Busy';
      case AllyOnlineStatus.offline:
        return 'Offline';
    }
  }

  Color statusColor(AllyOnlineStatus s) {
    switch (s) {
      case AllyOnlineStatus.online:
        return const Color(0xFF1DAF6B); // green
      case AllyOnlineStatus.busy:
        return const Color(0xFFF59E0B); // orange
      case AllyOnlineStatus.offline:
        return AppColors.subTextColor; // grey
    }
  }
}