import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/favorite/model/favorite_model.dart';

class FavoriteController extends GetxController {
  // ── Observable list ──────────────────────────────────────────────────────────
  final RxList<FavoriteModel> favorites = <FavoriteModel>[
    const FavoriteModel(
      id: '1',
      name: 'Aanya',
      image: 'https://randomuser.me/api/portraits/women/44.jpg',
      status: FavoriteStatus.online,
      isVerified: true,
      isFavorited: true,
      latestSessionType: 'Chat',
      latestSessionTime: '12m',
    ),
    const FavoriteModel(
      id: '2',
      name: 'Mera',
      image: 'https://randomuser.me/api/portraits/women/65.jpg',
      status: FavoriteStatus.onACall,
      isVerified: true,
      isFavorited: true,
      latestSessionType: 'Chat',
      latestSessionTime: '12m',
      estimatedWait: '~8m',
    ),
    const FavoriteModel(
      id: '3',
      name: 'Alisha',
      image: 'https://randomuser.me/api/portraits/women/32.jpg',
      status: FavoriteStatus.online,
      isVerified: true,
      isFavorited: true,
      latestSessionType: 'Chat',
      latestSessionTime: '12m',
    ),
    const FavoriteModel(
      id: '4',
      name: 'Ria',
      image: 'https://randomuser.me/api/portraits/women/12.jpg',
      status: FavoriteStatus.availableLater,
      isVerified: true,
      isFavorited: true,
      rating: 4.8,
      reviews: 9,
      hours: 410,
      estimatedWait: '~8m',
    ),
  ].obs;

  // ── Toggle favorite ──────────────────────────────────────────────────────────
  void toggleFavorite(String id) {
    final index = favorites.indexWhere((f) => f.id == id);
    if (index == -1) return;
    favorites[index] = favorites[index].copyWith(
      isFavorited: !favorites[index].isFavorited,
    );
  }

  // ── Remove from favorites ─────────────────────────────────────────────────────
  void removeFromFavorites(String id) {
    favorites.removeWhere((f) => f.id == id);
  }

  // ── Notify me ────────────────────────────────────────────────────────────────
  void notifyMe(String id) {
    Get.snackbar(
      'Reminder Set',
      'We\'ll notify you when they\'re available.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  // ── Talk now ─────────────────────────────────────────────────────────────────
  void talkNow(FavoriteModel ally) {
    // TODO: navigate to call/chat screen
    // Get.toNamed('/talk', arguments: ally);
  }
}