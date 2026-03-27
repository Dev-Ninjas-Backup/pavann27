// story_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/story/controller/story_controller.dart';

class StoryScreen extends StatelessWidget {
  final StoryController controller = Get.put(StoryController());

  StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.stories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final currentStory = controller.stories[controller.currentIndex.value];

        return Stack(
          children: [
            // Background Story Image
            Positioned.fill(
              child: Image.network(
                currentStory.storyImageUrl,
                fit: BoxFit.cover,
              ),
            ),

            // Gradient Overlay (top & bottom)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black54,
                      Colors.transparent,
                      Colors.black54,
                    ],
                  ),
                ),
              ),
            ),

            // Top Bar (Progress + User Info)
            SafeArea(
              child: Column(
                children: [
                  // Progress Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: List.generate(
                        controller.stories.length,
                        (index) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: LinearProgressIndicator(
                              value: controller.currentIndex.value == index
                                  ? controller.progress.value
                                  : controller.currentIndex.value > index
                                      ? 1.0
                                      : 0.0,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation(Colors.white),
                              minHeight: 2.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // User Info Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        // Profile Picture
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(currentStory.profileImageUrl),
                        ),
                        const SizedBox(width: 10),

                        // Username + Time
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  currentStory.username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                if (currentStory.isVerified)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Icon(Icons.verified, color: Colors.blue, size: 18),
                                  ),
                              ],
                            ),
                            Text(
                              currentStory.timeAgo,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Close Button
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 28),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tap Areas for Previous / Next Story
            Row(
              children: [
                // Left side - Previous Story
                Expanded(
                  child: GestureDetector(
                    onTap: controller.previousStory,
                    behavior: HitTestBehavior.translucent,
                  ),
                ),
                // Right side - Next Story
                Expanded(
                  child: GestureDetector(
                    onTap: controller.nextStory,
                    behavior: HitTestBehavior.translucent,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}