// chat_controller.dart
import 'package:get/get.dart';
import 'package:pavann27/features/chat/model/chat_model.dart';

class ChatController extends GetxController {
  final Rx<ChatUser> user = ChatUser(
    id: "1",
    name: "Amyra",
    profileImageUrl: "https://i.pravatar.cc/300?img=1", // Replace with real image
    bio: "I went through a confusing phase in college and learned how much it helps to talk freely. During that time, I realized the power of having someone who just listens without judgment.",
    isOnline: true,
    isVerified: true,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      user.value = ChatUser(
        id: user.value.id,
        name: Get.arguments['name'] ?? user.value.name,
        profileImageUrl: Get.arguments['image'] ?? user.value.profileImageUrl,
        bio: user.value.bio,
        isOnline: true,
        isVerified: Get.arguments['isVerified'] ?? user.value.isVerified,
      );
    }
  }

  // You can add more logic here later (send message, load messages, etc.)
}