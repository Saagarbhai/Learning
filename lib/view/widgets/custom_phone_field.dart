import 'package:learning/core/utils/app_export.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String countryCode;
  final Function(String)? onCountryCodeChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const CustomPhoneField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.countryCode = '+91',
    this.onCountryCodeChanged,
    this.focusNode,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: 16.sp,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        hintStyle: TextStyle(
          fontSize: 16.sp,
          color: Color(0xFFAAAAAA),
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            EdgeInsets.only(left: 100.w, right: 16.w, top: 16.h, bottom: 16.h),
        prefixIcon: InkWell(
          onTap: () {
            // Show country code picker if needed
            if (onCountryCodeChanged != null) {
              // Implement country code picker logic here
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            margin: EdgeInsets.only(right: 8.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Country flag
                Container(
                  width: 24.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: SvgPicture.asset(
                    Assets.images.flag.indian.path,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8.w),
                // Dropdown icon
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16.sp,
                  color: Color(0xFF666666),
                ),
                SizedBox(width: 8.w),
                // Country code
                Text(
                  countryCode,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF1A1A1A),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(width: 8.w),
                // Vertical divider
                Container(
                  height: 24.h,
                  width: 1.w,
                  color: const Color(0xFFE0E0E0),
                ),
              ],
            ),
          ),
        ),
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
