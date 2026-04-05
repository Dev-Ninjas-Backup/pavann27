enum NotificationType { newMessage, milestone, newAlly, lowBalance, system }

enum NotificationGroup { today, yesterday, earlier }

class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final String timeLabel;
  final NotificationGroup group;
  final bool isRead;
  final bool isDeleted;

  // For message / ally notifications — show avatar image
  final String? avatarUrl;

  // For system notifications (milestone, low balance) — show icon with bg color
  final bool hasIconBadge;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.timeLabel,
    required this.group,
    this.isRead = false,
    this.isDeleted = false,
    this.avatarUrl,
    this.hasIconBadge = false,
  });

  NotificationModel copyWith({bool? isRead, bool? isDeleted}) {
    return NotificationModel(
      id: id,
      type: type,
      title: title,
      body: body,
      timeLabel: timeLabel,
      group: group,
      isRead: isRead ?? this.isRead,
      isDeleted: isDeleted ?? this.isDeleted,
      avatarUrl: avatarUrl,
      hasIconBadge: hasIconBadge,
    );
  }
}