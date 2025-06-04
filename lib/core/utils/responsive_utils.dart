import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Utility class for responsive design
class ResponsiveUtils {
  /// Design width: 393px
  static const double designWidth = 393;

  /// Design height: 852px
  static const double designHeight = 852;

  /// Convert a horizontal value to responsive width
  static double w(double width) => width.w;

  /// Convert a vertical value to responsive height
  static double h(double height) => height.h;

  /// Convert a value to responsive radius (min of width and height)
  static double r(double radius) => radius.r;

  /// Convert a value to responsive font size
  static double sp(double fontSize) => fontSize.sp;

  /// Get screen width
  static double getScreenWidth() => 1.sw;

  /// Get screen height
  static double getScreenHeight() => 1.sh;

  /// Check if the current device is a tablet (width > 600dp)
  static bool isTablet() => 1.sw > 600;
}
