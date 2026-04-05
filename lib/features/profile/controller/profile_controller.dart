
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/profile/model/profile_model.dart';

class ProfileController extends GetxController {
  // ── Observable state ─────────────────────────────────────────────────────────
  final Rx<ProfileModel> profile = const ProfileModel().obs;
  final RxBool isDarkMode = false.obs;

  // ── Theme toggle ─────────────────────────────────────────────────────────────
  void toggleTheme(bool dark) {
    isDarkMode.value = dark;
    profile.value = profile.value.copyWith(isDarkMode: dark);
    Get.changeThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
  }

  // ── Logout ───────────────────────────────────────────────────────────────────
  void logout() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: clear session and navigate to login
              // Get.offAllNamed('/login');
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // ── Delete account ───────────────────────────────────────────────────────────
  void deleteAccount() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Account',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'This action is permanent and cannot be undone. All your data will be erased.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: call delete account API
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // ── Nav actions (stubs — replace with real routes) ───────────────────────────
  void openWallet() {
    // Get.toNamed('/wallet');
  }

  void openNotifications() {
    // Get.toNamed('/notifications');
  }

  void openPrivacySecurity() {
    // Get.toNamed('/privacy');
  }

  void openHelpSupport() {
    // Get.toNamed('/help');
  }
}
