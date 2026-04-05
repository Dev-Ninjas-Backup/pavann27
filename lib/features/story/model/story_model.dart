// story_model.dart
class Story {
  final String id;
  final String username;
  final String profileImageUrl;
  final String storyImageUrl;
  final DateTime createdAt;
  final bool isVerified;

  Story({
    required this.id,
    required this.username,
    required this.profileImageUrl,
    required this.storyImageUrl,
    required this.createdAt,
    this.isVerified = false,
  });

  // Time ago calculation
  String get timeAgo {
    final difference = DateTime.now().difference(createdAt);
    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}