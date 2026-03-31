import 'dart:async';
import 'package:get/get.dart';
import 'package:pavann27/core/common/constants/iconpath.dart';
import 'package:pavann27/features/call/model/call_model.dart';

class CallController extends GetxController {
  // ── Observable state ─────────────────────────────────────────────────────────
  final Rx<CallModel> call = CallModel(
    id: 'c1',
    allyName: 'Amyra',
    allyImage: Iconpath.profileWoman1,
    type: CallType.chat,
    state: CallState.connecting,
    elapsedSeconds: 0,
  ).obs;

  // ── Pulsing animation for the ring ───────────────────────────────────────────
  final RxBool pulseLarge = false.obs;

  Timer? _timer;
  Timer? _pulseTimer;
  Timer? _connectTimer;

  @override
  void onInit() {
    super.onInit();
    _startPulse();
    _simulateConnect();
  }

  // ── Pulse ring animation ──────────────────────────────────────────────────────
  void _startPulse() {
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 900), (_) {
      pulseLarge.value = !pulseLarge.value;
    });
  }

  // ── Simulate connection after 3 seconds ───────────────────────────────────────
  void _simulateConnect() {
    _connectTimer = Timer(const Duration(seconds: 3), () {
      if (call.value.state == CallState.connecting) {
        call.value = call.value.copyWith(state: CallState.connected);
        _startTimer();
      }
    });
  }

  // ── Session timer (counts up) ────────────────────────────────────────────────
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      call.value = call.value.copyWith(
        elapsedSeconds: call.value.elapsedSeconds + 1,
      );
    });
  }

  // ── Cancel / end call ─────────────────────────────────────────────────────────
  void cancelCall() {
    _stopAll();
    call.value = call.value.copyWith(state: CallState.cancelled);
    Get.back();
  }

  void endCall() {
    _stopAll();
    call.value = call.value.copyWith(state: CallState.ended);
    Get.back();
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

  // ── Helpers ──────────────────────────────────────────────────────────────────
  bool get isConnecting => call.value.state == CallState.connecting;
  bool get isConnected => call.value.state == CallState.connected;
}