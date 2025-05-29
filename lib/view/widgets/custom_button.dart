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

  const CustomButton({
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
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: isPrimary && border == null
            ? null
            : Border.all(
                color: border ?? const Color(0xFF00A86B),
                width: borderWidth,
              ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: bgColor
                      .withOpacity(isLoading || onPressed == null ? 0.1 : 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
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
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: txtColor,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 12),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: txtColor,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 12),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
