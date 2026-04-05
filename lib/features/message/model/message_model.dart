class MessageModel {
  final String id;
  final String name;
  final String image;
  final String lastMessage;
  final String timeLabel;
  final bool isOnline;
  final bool isVerified;
  final bool isUnread;

  const MessageModel({
    required this.id,
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.timeLabel,
    this.isOnline = false,
    this.isVerified = false,
    this.isUnread = false,
  });

  MessageModel copyWith({bool? isUnread}) {
    return MessageModel(
      id: id,
      name: name,
      image: image,
      lastMessage: lastMessage,
      timeLabel: timeLabel,
      isOnline: isOnline,
      isVerified: isVerified,
      isUnread: isUnread ?? this.isUnread,
    );
  }
}