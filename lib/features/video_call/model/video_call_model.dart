enum VideoCallState { connecting, connected, ended }

class VideoCallModel {
  final String id;
  final String allyName;
  final String allyImage;
  final VideoCallState state;
  final int elapsedSeconds;
  final bool isMicOn;
  final bool isCameraOn;
  final bool isFrontCamera;

  const VideoCallModel({
    required this.id,
    required this.allyName,
    required this.allyImage,
    this.state = VideoCallState.connecting,
    this.elapsedSeconds = 0,
    this.isMicOn = false,
    this.isCameraOn = true,
    this.isFrontCamera = true,
  });

  VideoCallModel copyWith({
    VideoCallState? state,
    int? elapsedSeconds,
    bool? isMicOn,
    bool? isCameraOn,
    bool? isFrontCamera,
  }) {
    return VideoCallModel(
      id: id,
      allyName: allyName,
      allyImage: allyImage,
      state: state ?? this.state,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isMicOn: isMicOn ?? this.isMicOn,
      isCameraOn: isCameraOn ?? this.isCameraOn,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
    );
  }

  /// "00:00" format
  String get formattedTime {
    final m = elapsedSeconds ~/ 60;
    final s = elapsedSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}