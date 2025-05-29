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
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xFFAAAAAA),
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.only(right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Country flag
              Container(
                width: 24,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                ),
                child: SvgPicture.asset(
                  Assets.images.flag.indian.path,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              // Dropdown icon
              const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Color(0xFF666666),
              ),
              const SizedBox(width: 8),
              // Country code
              Text(
                countryCode,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1A1A1A),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(width: 8),
              // Vertical divider
              Container(
                height: 24,
                width: 1,
                color: const Color(0xFFE0E0E0),
              ),
            ],
          ),
        ),
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
      ),
    );
  }
}
