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
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            color: Color(0xFF333333),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF9E9E9E),
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFF00A86B), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
        width: 50,
        height: 50,
        alignment: Alignment.center,
        child: Icon(
          isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: Colors.grey,
          size: 22,
        ),
      ),
    );
  }
}
