import 'package:get/get.dart';
import 'package:pavann27/features/splash_screen/view/splash_screen.dart';
import 'package:pavann27/features/bottom_navbar/screen/bottom_navbar_screen.dart';
import 'package:pavann27/features/login/screen/lgoin_screen.dart';
import 'package:pavann27/features/notification/screen/notification_screen.dart';
import 'package:pavann27/features/otp/screen/otp_screen.dart';
import 'package:pavann27/features/success/screen/success_screen.dart';
import 'package:pavann27/features/topup/screen/topup_screen.dart';

/// Centralized routing configuration for the application
/// Defines all app routes and their corresponding screens
class AppRoute {
  /// Route name constants
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String success = '/success';
  static const String otp = '/otp'; // Added OTP route
  static const String home = '/home';
  static const String notifications = '/notifications'; // Added notifications route
  static const String topup = '/topup'; // Added topup route

  /// All available routes in the application
  /// Add new routes here for any new screens
  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () =>  SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: success,
      page: () => SuccessScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: otp, // Use the new OTP route constant
      page: () => OtpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => BottomNavbarScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: notifications,
      page: () => NotificationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: topup,
      page: () => TopupScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}