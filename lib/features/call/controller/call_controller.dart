import 'dart:async';
import 'package:get/get.dart';
import 'package:pavann27/features/call/model/call_model.dart';

class CallController extends GetxController {
  final Rx<CallModel> call = const CallModel(
    id: '1',
    allyName: 'Amyra',
    allyImage: 'https://i.pravatar.cc/300?img=1',
    type: CallType.voice,
    state: CallState.ringing,
  ).obs;

  Timer? _timer;
  Timer? _pulseTimer;
  final RxBool pulseLarge = false.obs;

  bool get isConnecting => call.value.state == CallState.connecting;

  @override
  void onInit() {
    super.onInit();
    _startPulse();
  }

  void _startPulse() {
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      pulseLarge.toggle();
    });
  }

  /// Transitions an incoming 'ringing' call to 'connected' status and starts the timer.
  void acceptCall() {
    if (call.value.state != CallState.ringing) return;

    call.value = call.value.copyWith(
      state: CallState.connected,
    );

    _startTimer();
  }

  /// Declines an incoming call.
  void declineCall() {
    call.value = call.value.copyWith(state: CallState.cancelled);
    _stopTimers();
  }

  /// Cancels an outgoing call attempt.
  void cancelCall() {
    call.value = call.value.copyWith(state: CallState.cancelled);
    _stopTimers();
  }

  /// Ends the current call and stops the duration timer.
  void endCall() {
    call.value = call.value.copyWith(state: CallState.ended);
    _stopTimers();
    Get.back();
  }

  void _stopTimers() {
    _timer?.cancel();
    _pulseTimer?.cancel();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (call.value.state == CallState.connected) {
        call.value = call.value.copyWith(
          elapsedSeconds: call.value.elapsedSeconds + 1,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _stopTimers();
    super.onClose();
  }
}