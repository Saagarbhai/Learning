import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/utils/app_export.dart';

class CircularProgressButton extends StatelessWidget {
  final double size;
  final bool showGoText;
  final VoidCallback onPressed;
  final int? pageIndex;
  final bool navigateDirectlyToWelcome;

  const CircularProgressButton({
    Key? key,
    required this.size,
    required this.onPressed,
    this.showGoText = false,
    this.pageIndex,
    this.navigateDirectlyToWelcome = false,
  }) : super(key: key);

  double _getProgressPercent() {
    if (pageIndex != null) {
      switch (pageIndex) {
        case 0:
          return 0.33;
        case 1:
          return 0.66;
        case 2:
          return 1;
        default:
          return 1;
      }
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the actual size in pixels based on screen size
    final actualSize = size.r;
    final radius = actualSize / 2;

    return GestureDetector(
      onTap: () {
        if (navigateDirectlyToWelcome && showGoText) {
          // Skip the animation and directly navigate to the welcome screen
          Navigator.of(context).pushReplacementNamed(
            AppConstants.welcomeRoute,
            result: false,
          );
        } else {
          onPressed();
        }
      },
      child: Container(
        width: actualSize,
        height: actualSize,
        child: CircularPercentIndicator(
          radius: radius,
          lineWidth: 4.w,
          percent: _getProgressPercent(),
          progressColor: Color(0xFF08B783),
          backgroundColor: Colors.grey.shade200,
          center: Container(
            width: actualSize - 15.w,
            height: actualSize - 15.w,
            decoration: BoxDecoration(
              color: Color(0xFF08B783),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Center(
              child: showGoText
                  ? Text(
                      'Go',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (actualSize * 0.25).sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: (actualSize * 0.4).sp,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
