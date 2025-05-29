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
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xFF666666),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xFFAAAAAA),
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
      style: const TextStyle(
        fontSize: 16,
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
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1A1A1A),
              fontFamily: 'Poppins',
            ),
          ),
        );
      }).toList(),
    );
  }
}
