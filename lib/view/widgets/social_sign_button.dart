import 'package:learning/core/utils/app_export.dart';

class SocialSignButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget icon;
  final bool isDisabled;

  const SocialSignButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.icon,
    this.isDisabled = true, // Default to disabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed:
          isDisabled ? null : onPressed, // Disable button if isDisabled is true
      isPrimary: false,
      prefixIcon: icon,
      width: double.infinity,
      height: 56.h,
      backgroundColor: Colors.white,
      textColor: const Color(0xFF1A1A1A),
      borderColor: const Color(0xFFE0E0E0),
      borderWidth: 1.w,
      margin: EdgeInsets.only(bottom: 12.h),
    );
  }

  // Factory constructors for different social platforms
  factory SocialSignButton.gmail({
    required VoidCallback onPressed,
    required String text,
    bool isDisabled = true, // Default to disabled
  }) {
    return SocialSignButton(
      text: text,
      onPressed: onPressed,
      isDisabled: isDisabled,
      icon: SvgPicture.asset(
        Assets.images.socialSignImage.gmail.path,
        width: 24.w,
        height: 24.h,
      ),
    );
  }

  factory SocialSignButton.facebook({
    required VoidCallback onPressed,
    required String text,
    bool isDisabled = true, // Default to disabled
  }) {
    return SocialSignButton(
      text: text,
      onPressed: onPressed,
      isDisabled: isDisabled,
      icon: SvgPicture.asset(
        Assets.images.socialSignImage.facebook.path,
        width: 24.w,
        height: 24.h,
      ),
    );
  }

  factory SocialSignButton.apple({
    required VoidCallback onPressed,
    required String text,
    bool isDisabled = true, // Default to disabled
  }) {
    return SocialSignButton(
      text: text,
      onPressed: onPressed,
      isDisabled: isDisabled,
      icon: SvgPicture.asset(
        Assets.images.socialSignImage.apple.path,
        width: 24.w,
        height: 24.h,
      ),
    );
  }
}
