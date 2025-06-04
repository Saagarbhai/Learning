import '../../core/utils/app_export.dart';

class CustomSignInPasswordField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomSignInPasswordField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) {
        return previous.isPasswordVisible != current.isPasswordVisible;
      },
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          obscureText: !state.isPasswordVisible,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            color: Color(0xFF333333),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xFF9E9E9E),
              fontFamily: 'Poppins',
              fontSize: 16.sp,
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
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            suffixIcon:
                _buildVisibilityToggle(context, state.isPasswordVisible),
          ),
          onChanged: onChanged,
          validator: validator,
        );
      },
    );
  }

  Widget _buildVisibilityToggle(BuildContext context, bool isVisible) {
    return GestureDetector(
      onTap: () {
        context.read<SignInBloc>().add(ToggleSignInPasswordVisibility());
      },
      child: Container(
        width: 50.w,
        height: 50.h,
        alignment: Alignment.center,
        child: Icon(
          isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: Colors.grey,
          size: 22.sp,
        ),
      ),
    );
  }
}
