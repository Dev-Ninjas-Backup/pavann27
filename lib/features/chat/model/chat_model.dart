// chat_model.dart
class ChatUser {
  final String id;
  final String name;
  final String profileImageUrl;
  final String bio;
  final bool isOnline;
  final bool isVerified;

  ChatUser({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.bio,
    this.isOnline = false,
    this.isVerified = false,
  });
}