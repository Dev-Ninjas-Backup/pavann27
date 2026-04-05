import 'package:get/get.dart';
import 'package:pavann27/features/notification/model/notification_model.dart';

class NotificationController extends GetxController {
  // ── Observable list ──────────────────────────────────────────────────────────
  final RxList<NotificationModel> notifications = <NotificationModel>[
    // ── Today ──────────────────────────────────────────────────────────────────
    const NotificationModel(
      id: '1',
      type: NotificationType.newMessage,
      title: 'New message',
      body: 'Aanya: "Hey, hope you\'re doing wel...',
      timeLabel: '2h ago',
      group: NotificationGroup.today,
      isRead: true,
      avatarUrl: null, // greyed out — read + dismissed state shown in design
    ),
    const NotificationModel(
      id: '2',
      type: NotificationType.newMessage,
      title: 'New message',
      body: 'Aanya: "Hey, hope you\'re doing well today!"',
      timeLabel: '2h ago',
      group: NotificationGroup.today,
      isRead: false,
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    ),

    // ── Yesterday ──────────────────────────────────────────────────────────────
    const NotificationModel(
      id: '3',
      type: NotificationType.milestone,
      title: 'Milestone reached!',
      body: 'You\'ve completed 10 sessions. Keep going!',
      timeLabel: '1d ago',
      group: NotificationGroup.yesterday,
      isRead: false,
      hasIconBadge: true,
    ),
    const NotificationModel(
      id: '4',
      type: NotificationType.newAlly,
      title: 'New ally available',
      body: 'Kavya is now online and ready to chat',
      timeLabel: '1d ago',
      group: NotificationGroup.yesterday,
      isRead: true,
      hasIconBadge: true,
    ),
    const NotificationModel(
      id: '5',
      type: NotificationType.newMessage,
      title: 'New message',
      body: 'Sara: "Thanks for the great conversation!"',
      timeLabel: '1d ago',
      group: NotificationGroup.yesterday,
      isRead: true,
      avatarUrl: 'https://randomuser.me/api/portraits/women/32.jpg',
    ),

    // ── Earlier ────────────────────────────────────────────────────────────────
    const NotificationModel(
      id: '6',
      type: NotificationType.lowBalance,
      title: 'Low balance',
      body: 'Your wallet balance is running low. Top up to continue.',
      timeLabel: '3d ago',
      group: NotificationGroup.earlier,
      isRead: true,
      hasIconBadge: true,
    ),
    const NotificationModel(
      id: '7',
      type: NotificationType.newMessage,
      title: 'New message',
      body: 'Ishita: "Let me know if you want to talk again"',
      timeLabel: '4d ago',
      group: NotificationGroup.earlier,
      isRead: true,
      avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
    ),
    const NotificationModel(
      id: '8',
      type: NotificationType.milestone,
      title: 'First week complete!',
      body: 'You\'ve been with Allies for a week now',
      timeLabel: '17 Feb',
      group: NotificationGroup.earlier,
      isRead: true,
      hasIconBadge: true,
    ),
  ].obs;

  // ── Unread count ─────────────────────────────────────────────────────────────
  int get unreadCount =>
      notifications.where((n) => !n.isRead && !n.isDeleted).length;

  // ── Mark single as read ───────────────────────────────────────────────────────
  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index == -1) return;
    notifications[index] = notifications[index].copyWith(isRead: true);
  }

  // ── Dismiss (soft delete) ─────────────────────────────────────────────────────
  void dismiss(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  // ── Clear all ─────────────────────────────────────────────────────────────────
  void clearAll() {
    notifications.clear();
  }

  // ── Grouped getters ───────────────────────────────────────────────────────────
  List<NotificationModel> get todayItems =>
      notifications.where((n) => n.group == NotificationGroup.today).toList();

  List<NotificationModel> get yesterdayItems =>
      notifications.where((n) => n.group == NotificationGroup.yesterday).toList();

  List<NotificationModel> get earlierItems =>
      notifications.where((n) => n.group == NotificationGroup.earlier).toList();
}