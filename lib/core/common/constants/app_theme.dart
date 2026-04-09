import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App Theme Configuration
/// Contains light and dark themes with complete customization
class AppTheme {
  // Color Constants
  static const Color primaryColor = Color(0xFF7B61FF);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color errorColor = Color(0xFFE53935);
  static const Color surfaceColor = Color(0xFFFAFAFA);
  static const Color backgroundColor = Colors.white;
  static const Color textColorDark = Color(0xFF1F1F1F);
  static const Color textColorLight = Color(0xFF757575);
  static const Color borderColor = Color(0xFFE0E0E0);

  // Layout Constants
  static const double cornerRadius = 12;
  static const double largeCornerRadius = 16;

  /// Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onError: Colors.white,
        onSurface: textColorDark,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: textColorDark,
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: textColorDark,
          letterSpacing: 0.3,
        ),
        iconTheme: const IconThemeData(color: textColorDark),
      ),

      // Text Theme
      textTheme: _buildTextTheme(),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: textColorLight,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          side: const BorderSide(color: primaryColor, width: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        color: Colors.white,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: backgroundColor,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(largeCornerRadius),
            topRight: Radius.circular(largeCornerRadius),
          ),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(largeCornerRadius),
        ),
        elevation: 8,
        backgroundColor: backgroundColor,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
      ),
    );
  }

  /// Dark Theme Configuration
  static ThemeData get darkTheme {
    const Color darkBg = Color(0xFF121212);
    const Color darkSurface = Color(0xFF1E1E1E);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBg,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        surface: darkSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onError: Colors.white,
        onSurface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: darkSurface,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      textTheme: _buildDarkTextTheme(),
    );
  }

  /// Build light theme text styles
  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700, color: Color(0xFF1F1F1F), height: 1.2),
      displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700, color: Color(0xFF1F1F1F), height: 1.2),
      displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: Color(0xFF1F1F1F), height: 1.3),
      headlineSmall: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF1F1F1F), height: 1.3),
      titleLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Color(0xFF1F1F1F), height: 1.4),
      titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Color(0xFF1F1F1F), height: 1.4),
      titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Color(0xFF1F1F1F), height: 1.4),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF1F1F1F), height: 1.5),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF1F1F1F), height: 1.5),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF757575), height: 1.5),
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF1F1F1F), height: 1.4),
      labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Color(0xFF757575), height: 1.4),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Color(0xFF757575), height: 1.3),
    );
  }

  /// Build dark theme text styles
  static TextTheme _buildDarkTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2),
      displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2),
      displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: Colors.white, height: 1.3),
      headlineSmall: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.white, height: 1.3),
      titleLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white, height: 1.4),
      titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white, height: 1.4),
      titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white, height: 1.4),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.white, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey[400], height: 1.5),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.grey[500], height: 1.5),
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white, height: 1.4),
      labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.grey[400], height: 1.4),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Colors.grey[500], height: 1.3),
    );
  }
}