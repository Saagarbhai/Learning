import 'package:learning/core/utils/app_export.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final double? width;
  final double height;
  final bool isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool showShadow;
  final Color? borderColor;
  final double borderWidth;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? margin;

  CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.width,
    this.height = 56,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
    this.padding,
    this.showShadow = false,
    this.borderColor,
    this.borderWidth = 2,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor =
        backgroundColor ?? (isPrimary ? const Color(0xFF00A86B) : Colors.white);
    final txtColor =
        textColor ?? (isPrimary ? Colors.white : const Color(0xFF00A86B));
    final border = borderColor ?? (isPrimary ? null : const Color(0xFF00A86B));

    return Container(
      width: width?.w,
      height: height.h,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: isPrimary && border == null
            ? null
            : Border.all(
                color: border ?? const Color(0xFF00A86B),
                width: borderWidth.w,
              ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: bgColor
                      .withOpacity(isLoading || onPressed == null ? 0.1 : 0.25),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          disabledBackgroundColor: bgColor.withOpacity(0.5),
          foregroundColor: txtColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: CircularProgressIndicator(
                  color: txtColor,
                  strokeWidth: 2.w,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: 12.w),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize.sp,
                      fontWeight: fontWeight,
                      color: txtColor,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: 12.w),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
