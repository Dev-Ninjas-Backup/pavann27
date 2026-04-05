import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/home/model/ally_search_model.dart';
import 'package:pavann27/features/home/model/home_page_model.dart';


class HomePageController extends GetxController {
  final RxList<String> selectedAllies = <String>[].obs;
  final TextEditingController searchController = TextEditingController();

  void toggleAllySelection(String name) {
    if (selectedAllies.contains(name)) {
      selectedAllies.remove(name);
    } else {
      selectedAllies.add(name);
    }
  }

  final RxList<HomePageModel> allAllies = <HomePageModel>[
    HomePageModel(
      name: 'Aanya',
      age: 25,
      image: 'https://i.pravatar.cc/300?img=32',
      rating: 4.8,
      reviews: 9,
      hours: 410,
      bio: "Hey, I'm around if you feel like talking.",
      status: 'Online now',
      isOnline: true,
      isVerified: true,
      canTalkNow: true,
    ),
    HomePageModel(
      name: 'Mera',
      age: 25,
      image: 'https://i.pravatar.cc/300?img=44',
      rating: 4.8,
      reviews: 9,
      hours: 410,
      bio: 'I went through a confusing phase in college and learned how to manage emotions better.',
      status: 'On a call',
      isOnline: false,
      isVerified: true,
      canTalkNow: false,
      estimatedTime: 'est. ~8m',
    ),
    HomePageModel(
      name: 'Ria',
      age: 25,
      image: 'https://i.pravatar.cc/300?img=48',
      rating: 4.8,
      reviews: 9,
      hours: 410,
      bio: 'I went through a confusing phase in college and learned how to manage emotions better.',
      status: 'Online now',
      isOnline: true,
      isVerified: true,
      canTalkNow: true,
    ),
    HomePageModel(
      name: 'Sara',
      age: 25,
      image: 'https://i.pravatar.cc/300?img=47',
      rating: 4.8,
      reviews: 9,
      hours: 410,
      bio: 'I went through a confusing phase in college and learned how to manage emotions better.',
      status: 'Available later',
      isOnline: false,
      isVerified: true,
      canTalkNow: false,
    ),
  ].obs;

  final RxList<HomePageModel> filteredAllies = <HomePageModel>[].obs;

  final List<Map<String, String>> topAllies = [
    {'name': 'Amyra', 'image': 'https://i.pravatar.cc/300?img=5'},
    {'name': 'Liya', 'image': 'https://i.pravatar.cc/300?img=20'},
    {'name': 'Rose', 'image': 'https://i.pravatar.cc/300?img=12'},
    {'name': 'Ishita', 'image': 'https://i.pravatar.cc/300?img=32'},
  ];

  final List<String> recentImages = [
    'https://i.pravatar.cc/300?img=32',
    'https://i.pravatar.cc/300?img=21',
    'https://i.pravatar.cc/300?img=47',
    'https://i.pravatar.cc/300?img=49',
    'https://i.pravatar.cc/300?img=20',
  ];

  @override
  void onInit() {
    super.onInit();
    filteredAllies.assignAll(allAllies);
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      filteredAllies.assignAll(allAllies);
      return;
    }

    filteredAllies.assignAll(
      allAllies.where(
        (ally) =>
            ally.name.toLowerCase().contains(query) ||
            ally.status.toLowerCase().contains(query),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'online now':
        return Colors.green;
      case 'on a call':
        return Colors.orange;
      case 'available later':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}