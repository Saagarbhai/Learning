import 'package:learning/core/utils/app_export.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final String? labelText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.autofocus = false,
    this.textInputAction,
    this.contentPadding,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focusNode,
      autofocus: autofocus,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: 16.sp,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        hintStyle: TextStyle(
          fontSize: 16.sp,
          color: Color(0xFFAAAAAA),
          fontFamily: 'Poppins',
        ),
        labelStyle: TextStyle(
          fontSize: 16.sp,
          color: Color(0xFF666666),
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Color(0xFF00A86B), width: 1.5.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red, width: 1.5.w),
        ),
      ),
    );
  }
}
