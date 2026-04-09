import 'package:get/get.dart';
import 'package:pavann27/features/splash_screen/model/splash_screen_model.dart';

class SplashScreenController extends GetxController {
  final SplashScreenModel model = const SplashScreenModel();

  // ── Animation state ──────────────────────────────────────────────────────────
  final RxDouble opacity = 0.0.obs;
  final RxDouble scale = 0.80.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 250));
    opacity.value = 1.0;
    scale.value = 1.0;
    await Future.delayed(model.splashDuration);
    _navigate();
  }

  void _navigate() {
    Get.offAllNamed('/login');
  }
}