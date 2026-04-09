class SplashScreenModel {
  final String appName;
  final Duration splashDuration;

  const SplashScreenModel({
    this.appName = 'allies',
    this.splashDuration = const Duration(seconds: 3),
  });
}