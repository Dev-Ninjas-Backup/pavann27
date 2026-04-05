class ChatMessage {
  final String text;
  final bool isSender;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isSender,
    required this.timestamp,
  });
}