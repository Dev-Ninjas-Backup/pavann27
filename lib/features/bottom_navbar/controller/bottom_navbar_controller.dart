import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  // Default to the Home screen (index 0)
  final RxInt currentIndex = 0.obs;

  final List<IconData> icons = [
    Icons.home_outlined,
    Icons.favorite_border_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.person_outline_rounded,
  ];

  final List<String> labels = [
    "Home",
    "Favorite",
    "Message",
    "Profile",
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}