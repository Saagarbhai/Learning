/// A utility class that provides validation functions for forms
class Validators {
  /// Email validation regex pattern
  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Phone number validation regex pattern (10 digits)
  static final RegExp _phoneRegex = RegExp(r'^\d{10}$');

  /// Password validation regex patterns
  static final RegExp _passwordNumberRegex = RegExp(r'[0-9]');
  static final RegExp _passwordSpecialCharRegex =
      RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  /// Validates an email address
  ///
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates a phone number
  ///
  /// Returns null if valid, error message if invalid
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!_phoneRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  /// Validates an email or phone number input
  ///
  /// Returns null if valid, error message if invalid
  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or phone number';
    }

    // Check if input is a valid email or phone number
    final bool isEmail = _emailRegex.hasMatch(value);
    final bool isPhone = _phoneRegex.hasMatch(value);

    if (!isEmail && !isPhone) {
      return 'Please enter a valid email or phone number';
    }

    return null;
  }

  /// Validates a password
  ///
  /// Returns null if valid, error message if invalid
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!_passwordNumberRegex.hasMatch(value) &&
        !_passwordSpecialCharRegex.hasMatch(value)) {
      return 'Password must contain at least 1 number or special character';
    }

    return null;
  }

  /// Validates a confirm password field
  ///
  /// Returns null if valid, error message if invalid
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates a name field
  ///
  /// Returns null if valid, error message if invalid
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    return null;
  }

  /// Validates a required field
  ///
  /// Returns null if valid, error message if invalid
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  /// Checks if an email is valid
  ///
  /// Returns true if valid, false if invalid
  static bool isEmailValid(String email) {
    return _emailRegex.hasMatch(email);
  }

  /// Checks if a phone number is valid
  ///
  /// Returns true if valid, false if invalid
  static bool isPhoneValid(String phone) {
    return _phoneRegex.hasMatch(phone);
  }

  /// Checks if a password is valid
  ///
  /// Returns true if valid, false if invalid
  static bool isPasswordValid(String password) {
    return password.length >= 6 &&
        (_passwordNumberRegex.hasMatch(password) ||
            _passwordSpecialCharRegex.hasMatch(password));
  }

  /// Checks if an email or phone number is valid
  ///
  /// Returns true if valid, false if invalid
  static bool isEmailOrPhoneValid(String input) {
    return isEmailValid(input) || isPhoneValid(input);
  }
}
