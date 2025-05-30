import '../../core/utils/app_export.dart';

class CustomPasswordField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isValid;
  final bool showValidIndicator;
  final bool confirmField;
  final bool isConfirmMatch;

  const CustomPasswordField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.validator,
    this.isValid = false,
    this.showValidIndicator = true,
    this.confirmField = false,
    this.isConfirmMatch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
        buildWhen: (previous, current) {
      if (confirmField) {
        return previous.isConfirmPasswordVisible !=
            current.isConfirmPasswordVisible;
      } else {
        return previous.isPasswordVisible != current.isPasswordVisible;
      }
    }, builder: (context, state) {
      final isVisible = confirmField
          ? state.isConfirmPasswordVisible
          : state.isPasswordVisible;

      return TextFormField(
        controller: controller,
        obscureText: !isVisible,
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
            borderSide: const BorderSide(color: Color(0xFF00A86B), width: 1.5),
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
          suffixIcon: showValidIndicator
              ? _buildSuffixIcon(context, isVisible)
              : _buildVisibilityToggle(context, isVisible),
        ),
        onChanged: onChanged,
        validator: validator,
      );
    });
  }

  Widget _buildSuffixIcon(BuildContext context, bool isVisible) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Validation icon
        _buildValidationIcon(),
        // Visibility toggle
        _buildVisibilityToggle(context, isVisible),
      ],
    );
  }

  Widget _buildVisibilityToggle(BuildContext context, bool isVisible) {
    return GestureDetector(
      onTap: () {
        context
            .read<PasswordBloc>()
            .add(TogglePasswordVisibility(isConfirmField: confirmField));
      },
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: Icon(
          isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: Colors.grey,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildValidationIcon() {
    // For primary password field
    if (!confirmField) {
      // Only show check icon if the field is valid and not empty
      if (isValid) {
        return Container(
          width: 24,
          alignment: Alignment.center,
          child: const Icon(
            Icons.check,
            color: Colors.green,
            size: 18,
          ),
        );
      }
      return const SizedBox.shrink();
    }

    // For confirm password field
    else {
      // Only show check icon if the confirmation matches and is not empty
      if (isConfirmMatch && controller?.text.isNotEmpty == true) {
        return Container(
          width: 24,
          alignment: Alignment.center,
          child: const Icon(
            Icons.check,
            color: Colors.green,
            size: 18,
          ),
        );
      }
      return const SizedBox.shrink();
    }
  }
}
