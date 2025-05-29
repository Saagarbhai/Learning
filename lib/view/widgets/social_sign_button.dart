import 'package:learning/core/utils/app_export.dart';

class SocialSignButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget icon;

  const SocialSignButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isPrimary: false,
      prefixIcon: icon,
      width: double.infinity,
      height: 56,
      backgroundColor: Colors.white,
      textColor: const Color(0xFF1A1A1A),
      borderColor: const Color(0xFFE0E0E0),
      borderWidth: 1,
      margin: const EdgeInsets.only(bottom: 12),
    );
  }

  // Factory constructors for different social platforms
  factory SocialSignButton.gmail({
    required VoidCallback onPressed,
    required String text,
  }) {
    return SocialSignButton(
      text: text,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        Assets.images.socialSignImage.gmail.path,
        width: 24,
        height: 24,
      ),
    );
  }

  factory SocialSignButton.facebook({
    required VoidCallback onPressed,
    required String text,
  }) {
    return SocialSignButton(
      text: text,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        Assets.images.socialSignImage.facebook.path,
        width: 24,
        height: 24,
      ),
    );
  }

  factory SocialSignButton.apple({
    required VoidCallback onPressed,
    required String text,
  }) {
    return SocialSignButton(
      text: text,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        Assets.images.socialSignImage.apple.path,
        width: 24,
        height: 24,
      ),
    );
  }
}
