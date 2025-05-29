import 'package:learning/core/utils/app_export.dart';

class CustomPinBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onCompleted;
  final Function(String) onChanged;
  final int length;

  const CustomPinBox({
    Key? key,
    required this.controller,
    required this.onCompleted,
    required this.onChanged,
    this.length = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: length,
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1A1A),
          fontFamily: 'Poppins',
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1A1A),
          fontFamily: 'Poppins',
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF00A86B),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00A86B).withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color(0xFF00A86B),
          fontFamily: 'Poppins',
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF5FFF9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF00A86B),
            width: 1.5,
          ),
        ),
      ),
      errorPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.red,
          fontFamily: 'Poppins',
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 2,
            color: const Color(0xFF00A86B),
          ),
        ],
      ),
      onCompleted: onCompleted,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      closeKeyboardWhenCompleted: true,
    );
  }
}
