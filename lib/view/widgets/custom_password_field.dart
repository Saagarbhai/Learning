import '../../core/utils/app_export.dart';

class CustomPasswordField extends StatefulWidget {
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
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'Poppins',
        color: Color(0xFF333333),
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF9E9E9E),
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        suffixIcon: widget.showValidIndicator
            ? _buildSuffixIcon()
            : _buildVisibilityToggle(),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }

  Widget _buildSuffixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Validation icon
        _buildValidationIcon(),
        // Visibility toggle
        _buildVisibilityToggle(),
      ],
    );
  }

  Widget _buildVisibilityToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: Colors.grey,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildValidationIcon() {
    // For empty fields in non-confirm mode, show nothing
    if (!widget.confirmField &&
        !widget.isValid &&
        widget.controller?.text.isEmpty != false) {
      return const SizedBox.shrink();
    }

    // For confirm field
    if (widget.confirmField) {
      if (widget.controller?.text.isEmpty != false) {
        return const SizedBox.shrink();
      }
      return Container(
        width: 24,
        alignment: Alignment.center,
        child: Icon(
          Icons.check,
          color: Colors.green,
          size: 18,
        ),
      );
    }

    // For primary password field
    return widget.isValid
        ? Container(
            width: 24,
            alignment: Alignment.center,
            child: const Icon(
              Icons.check,
              color: Colors.green,
              size: 18,
            ),
          )
        : const SizedBox.shrink();
  }
}
