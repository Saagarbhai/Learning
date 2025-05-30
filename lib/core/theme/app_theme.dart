import 'package:learning/core/utils/app_export.dart';

/// Utility class for app theme and styles
class AppTheme {
  // Text styles
  static TextStyle get headingLarge => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      );

  static TextStyle get headingMedium => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      );

  static TextStyle get headingSmall => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      );

  static TextStyle get bodyLarge => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      );

  // Button styles
  static TextStyle get buttonText => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'Poppins',
      );

  // Input field styles
  static InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 16.sp,
        color: const Color(0xFFAAAAAA),
        fontFamily: 'Poppins',
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: const Color(0xFFE0E0E0), width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: const Color(0xFF00A86B), width: 1.5.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.red, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.red, width: 1.5.w),
      ),
    );
  }

  // Common spacing values
  static double get spacingXS => 4.r;
  static double get spacingS => 8.r;
  static double get spacingM => 16.r;
  static double get spacingL => 24.r;
  static double get spacingXL => 32.r;
  static double get spacingXXL => 48.r;

  // Common border radius
  static double get borderRadiusS => 4.r;
  static double get borderRadiusM => 8.r;
  static double get borderRadiusL => 12.r;
  static double get borderRadiusXL => 16.r;
  static double get borderRadiusXXL => 24.r;
  static double get borderRadiusCircular => 100.r;

  // App colors
  static const Color primaryColor = Color(0xFF00A86B);
  static const Color secondaryColor = Color(0xFF1A1A1A);
  static const Color backgroundColor = Colors.white;
  static const Color errorColor = Colors.red;
  static const Color textLightColor = Color(0xFF666666);
  static const Color textDarkColor = Color(0xFF1A1A1A);
  static const Color borderColor = Color(0xFFE0E0E0);
}
