import 'package:get/get.dart';
import 'package:pavann27/features/message/model/message_model.dart';

class MessageController extends GetxController {
  // ── Observable list ──────────────────────────────────────────────────────────
  final RxList<MessageModel> messages = <MessageModel>[
    const MessageModel(
      id: '1',
      name: 'Aanya',
      image: 'https://randomuser.me/api/portraits/women/44.jpg',
      lastMessage: 'Thanks for listening today...',
      timeLabel: 'Today',
      isOnline: true,
      isVerified: true,
      isUnread: false,
    ),
    const MessageModel(
      id: '2',
      name: 'Meera',
      image: 'https://randomuser.me/api/portraits/women/65.jpg',
      lastMessage: 'Missed call',
      timeLabel: '2 Days ago',
      isOnline: true,
      isVerified: true,
      isUnread: true,
    ),
    const MessageModel(
      id: '3',
      name: 'Ria',
      image: 'https://randomuser.me/api/portraits/women/12.jpg',
      lastMessage: 'Remember to be kind to yourself',
      timeLabel: '6 Days ago',
      isOnline: true,
      isVerified: true,
      isUnread: false,
    ),
  ].obs;

  // ── Mark as read ─────────────────────────────────────────────────────────────
  void markAsRead(String id) {
    final index = messages.indexWhere((m) => m.id == id);
    if (index == -1) return;
    messages[index] = messages[index].copyWith(isUnread: false);
  }

  // ── Open conversation ─────────────────────────────────────────────────────────
  void openConversation(MessageModel message) {
    markAsRead(message.id);
    // TODO: navigate to chat screen
    // Get.toNamed('/chat', arguments: message);
  }

  // ── Delete conversation ───────────────────────────────────────────────────────
  void deleteConversation(String id) {
    messages.removeWhere((m) => m.id == id);
  }

  int get unreadCount => messages.where((m) => m.isUnread).length;
}