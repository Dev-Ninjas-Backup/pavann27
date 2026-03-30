// chat_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/chat/controller/chat_controller.dart';
import 'package:pavann27/features/call/screen/call_screen.dart';
import 'package:pavann27/features/video_call/screen/video_call_screen.dart';
import 'package:pavann27/features/view_profile/screen/view_profile_screen.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: GestureDetector(
          onTap: () => Get.to(() => ViewProfileScreen()),
          child: Obx(() => Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(controller.user.value.profileImageUrl),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            controller.user.value.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (controller.user.value.isVerified)
                            const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(Icons.verified, color: Colors.blue, size: 18),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: controller.user.value.isOnline
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            controller.user.value.isOnline ? "Online" : "Offline",
                            style: TextStyle(
                              color: controller.user.value.isOnline
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.purple),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.purple),
            onPressed: () => Get.to(() => CallScreen()),
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.purple),
            onPressed: () => Get.to(() => VideoCallScreen()),
          ),
          
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.purple),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          // Large Profile Image + Info
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Big Profile Picture
                  GestureDetector(
                    onTap: () => Get.to(() => ViewProfileScreen()),
                    child: Obx(() => CircleAvatar(
                          radius: 85,
                          backgroundImage: NetworkImage(controller.user.value.profileImageUrl),
                        )),
                  ),

                  const SizedBox(height: 16),

                  // Name
                  Obx(() => Text(
                        controller.user.value.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )),

                  const SizedBox(height: 4),

                  // Online Status
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: controller.user.value.isOnline
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.user.value.isOnline ? "Online now" : "Offline",
                            style: TextStyle(
                                color: controller.user.value.isOnline
                                    ? Colors.green
                                    : Colors.grey,
                                fontSize: 15),
                          ),
                        ],
                      )),

                  const SizedBox(height: 30),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(
                        icon: Icons.person_outline,
                        label: "View Profile",
                        onTap: () {
                          Get.to(() => ViewProfileScreen());
                        },
                      ),
                      const SizedBox(width: 40),
                      _buildActionButton(
                        icon: Icons.favorite_border,
                        label: "Favorite",
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Bio
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(() => Text(
                          controller.user.value.bio,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15.5,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        )),
                  ),

                  const SizedBox(height: 100), // Extra space for input field
                ],
              ),
            ),
          ),

          // Message Input Field
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "type here",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C30ED),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Icon(icon, color: const Color(0xFF6C30ED), size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}