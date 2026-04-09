import 'package:get/get.dart';
import 'package:pavann27/features/bottom_navbar/controller/bottom_navbar_controller.dart';
import 'package:pavann27/features/splash_screen/controller/splash_screen_controller.dart';

/// Initial bindings for dependency injection
/// This class is responsible for initializing all controllers and services
/// that are required at app startup
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize controllers
    _initializeControllers();

    // Initialize services
    _initializeServices();

    // Initialize repositories
    _initializeRepositories();
  }

  /// Initialize all app controllers
  void _initializeControllers() {
    // Splash Screen Controller
    Get.put<SplashScreenController>(
      SplashScreenController(),
      permanent: false,
    );

    // Bottom Navigation Controller
    Get.put<BottomNavbarController>(
      BottomNavbarController(),
      permanent: true,
    );

    // Add more controllers here
    // Get.put<AuthController>(AuthController(), permanent: true);
    // Get.put<ChatController>(ChatController(), permanent: true);
    // Get.put<NotificationController>(NotificationController(), permanent: true);
  }

  /// Initialize all app services (API, Local Storage, etc.)
  void _initializeServices() {
    // Example: Initialize API Service
    // Get.put<ApiService>(ApiService(), permanent: true);

    // Example: Initialize Local Storage Service
    // Get.put<StorageService>(StorageService(), permanent: true);

    // Example: Initialize Firebase Service
    // Get.put<FirebaseService>(FirebaseService(), permanent: true);
  }

  /// Initialize all repositories for data management
  void _initializeRepositories() {
    // Example: Initialize User Repository
    // Get.put<UserRepository>(UserRepositoryImpl(), permanent: true);

    // Example: Initialize Chat Repository
    // Get.put<ChatRepository>(ChatRepositoryImpl(), permanent: true);

    // Example: Initialize Post Repository
    // Get.put<PostRepository>(PostRepositoryImpl(), permanent: true);
  }
}