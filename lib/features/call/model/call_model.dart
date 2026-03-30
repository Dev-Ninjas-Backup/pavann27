enum CallType { chat, voice, video }

enum CallState { connecting, connected, ended, cancelled }

class CallModel {
  final String id;
  final String allyName;
  final String allyImage;
  final CallType type;
  final CallState state;
  final int elapsedSeconds; // timer

  const CallModel({
    required this.id,
    required this.allyName,
    required this.allyImage,
    required this.type,
    this.state = CallState.connecting,
    this.elapsedSeconds = 0,
  });

  CallModel copyWith({
    CallState? state,
    int? elapsedSeconds,
  }) {
    return CallModel(
      id: id,
      allyName: allyName,
      allyImage: allyImage,
      type: type,
      state: state ?? this.state,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    );
  }

  /// Formats elapsedSeconds → "0:12" / "1:05"
  String get formattedTime {
    final m = elapsedSeconds ~/ 60;
    final s = elapsedSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  String get typeLabel {
    switch (type) {
      case CallType.chat:
        return 'Chat session';
      case CallType.voice:
        return 'Voice session';
      case CallType.video:
        return 'Video session';
    }
  }
}