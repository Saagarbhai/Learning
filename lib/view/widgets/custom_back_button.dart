import 'package:learning/core/utils/app_export.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomBackButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      child: GestureDetector(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF1A1A1A),
              size: 18,
            ),
            const SizedBox(width: 3),
            Text(
              Lang.of(context).back,
              style: const TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
