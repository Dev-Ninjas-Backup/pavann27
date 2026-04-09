import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/routes/app_routes.dart';

// A simple model for profile data
class Profile {
  final String displayName;
  final String subTitle;
  final String anonymityNote;
  final String walletBalance;

  Profile({
    required this.displayName,
    required this.subTitle,
    required this.anonymityNote,
    required this.walletBalance,
  });
}

class ProfileController extends GetxController {
  // Dummy profile data for demonstration
  final Rx<Profile> profile = Profile(
    displayName: 'Anonymous User',
    subTitle: 'You are currently anonymous',
    anonymityNote: 'Your identity is protected',
    walletBalance: '₹45',
  ).obs;

  // Reactive variable to track dark mode status
  final RxBool isDarkMode = Get.isDarkMode.obs;

  // Toggles the application's theme mode
  void toggleTheme(bool dark) {
    isDarkMode.value = dark;
    Get.changeThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
  }

  // Navigates to the wallet/topup screen
  void openWallet() {
    Get.toNamed(AppRoute.topup);
    Get.snackbar("Navigation", "Opening Wallet/Topup screen");
  }

  // Navigates to the notifications screen
  void openNotifications() {
    Get.toNamed(AppRoute.notifications);
    Get.snackbar("Navigation", "Opening Notifications screen");
  }

  // Placeholder for privacy and security settings
  void openPrivacySecurity() {
    Get.snackbar("Navigation", "Opening Privacy & Security settings");
  }

  // Placeholder for help and support
  void openHelpSupport() {
    Get.snackbar("Navigation", "Opening Help & Support");
  }

  // Handles user logout
  void logout() {
    Get.snackbar("Logged Out", "You have been successfully logged out.",
        backgroundColor: Colors.green, colorText: Colors.white);
    // Navigate to the login screen and clear the navigation stack
    Get.offAllNamed(AppRoute.login);
  }

  // Handles account deletion
  void deleteAccount() {
    Get.snackbar("Account Deletion", "Initiating account deletion process...",
        backgroundColor: Colors.red, colorText: Colors.white);
    // After deletion, navigate to login or a confirmation screen
    Get.offAllNamed(AppRoute.login);
  }
}