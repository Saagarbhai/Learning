import 'package:learning/core/utils/app_export.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool isExpanded;

  const CustomDropdownField({
    Key? key,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.isExpanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: isExpanded,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xFF666666),
        size: 24.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          color: Color(0xFFAAAAAA),
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
      style: TextStyle(
        fontSize: 16.sp,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      onChanged: onChanged,
      validator: validator,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              color: Color(0xFF1A1A1A),
              fontFamily: 'Poppins',
            ),
          ),
        );
      }).toList(),
    );
  }
}
