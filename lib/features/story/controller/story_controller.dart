// story_controller.dart
import 'package:get/get.dart';
import 'package:pavann27/features/story/model/story_model.dart';

class StoryController extends GetxController {
  final RxList<Story> stories = <Story>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadStories();
  }

  void loadStories() {
    if (Get.arguments != null) {
      stories.value = [
        Story(
          id: Get.arguments['id'] ?? '1',
          username: Get.arguments['name'] ?? 'User',
          profileImageUrl: Get.arguments['image'] ?? 'https://i.pravatar.cc/300?img=1',
          storyImageUrl:
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?q=80&w=2070',
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          isVerified: true,
        ),
      ];
    } else {
      stories.value = [
        Story(
          id: '1',
          username: 'Amyra',
          profileImageUrl: 'https://i.pravatar.cc/300?img=1',
          storyImageUrl:
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?q=80&w=2070',
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          isVerified: true,
        ),
      ];
    }
  }

  void nextStory() {
    if (currentIndex.value < stories.length - 1) {
      currentIndex.value++;
      progress.value = 0.0;
    } else {
      Get.back(); // Close story when finished
    }
  }

  void previousStory() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      progress.value = 0.0;
    }
  }
}