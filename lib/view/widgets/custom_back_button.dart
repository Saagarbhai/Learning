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
      width: 85.w,
      child: GestureDetector(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF1A1A1A),
              size: 18.sp,
            ),
            SizedBox(width: 3.w),
            Text(
              Lang.of(context).back,
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
