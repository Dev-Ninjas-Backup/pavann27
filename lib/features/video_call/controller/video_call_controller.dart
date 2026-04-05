
import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:pavann27/features/video_call/model/video_call_model.dart';

class VideoCallController extends GetxController {
  // ── Observable state ─────────────────────────────────────────────────────────
  final Rx<VideoCallModel> call = const VideoCallModel(
    id: 'vc1',
    allyName: 'Aliya',
    allyImage: 'https://randomuser.me/api/portraits/women/12.jpg',
    state: VideoCallState.connecting,
    elapsedSeconds: 0,
    isMicOn: false,
    isCameraOn: true,
    isFrontCamera: true,
  ).obs;

  // ── Pulse animation toggle ───────────────────────────────────────────────────
  final RxBool pulseLarge = false.obs;

  // ── Self-preview drag position ───────────────────────────────────────────────
  final Rx<Offset> previewOffset = const Offset(0, 0).obs;

  Timer? _timer;
  Timer? _pulseTimer;
  Timer? _connectTimer;

  @override
  void onInit() {
    super.onInit();
    _startPulse();
    _simulateConnect();
  }

  void _startPulse() {
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 900), (_) {
      pulseLarge.value = !pulseLarge.value;
    });
  }

  void _simulateConnect() {
    _connectTimer = Timer(const Duration(seconds: 3), () {
      if (call.value.state == VideoCallState.connecting) {
        call.value = call.value.copyWith(state: VideoCallState.connected);
        _startTimer();
        _pulseTimer?.cancel();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      call.value = call.value.copyWith(
        elapsedSeconds: call.value.elapsedSeconds + 1,
      );
    });
  }

  // ── Controls ─────────────────────────────────────────────────────────────────
  void toggleMic() =>
      call.value = call.value.copyWith(isMicOn: !call.value.isMicOn);

  void toggleCamera() =>
      call.value = call.value.copyWith(isCameraOn: !call.value.isCameraOn);

  void flipCamera() =>
      call.value = call.value.copyWith(isFrontCamera: !call.value.isFrontCamera);

  void endCall() {
    _stopAll();
    call.value = call.value.copyWith(state: VideoCallState.ended);
    Get.back();
  }

  // ── Preview drag ─────────────────────────────────────────────────────────────
  void updatePreviewOffset(Offset delta) {
    previewOffset.value = previewOffset.value + delta;
  }

  void _stopAll() {
    _timer?.cancel();
    _pulseTimer?.cancel();
    _connectTimer?.cancel();
  }

  @override
  void onClose() {
    _stopAll();
    super.onClose();
  }

  bool get isConnecting => call.value.state == VideoCallState.connecting;
}
