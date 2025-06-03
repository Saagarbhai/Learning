import 'package:flutter/material.dart';

/// A centralized manager for all GlobalKeys used across the application.
/// This allows each screen to have its own unique key rather than sharing one global key.
class KeysManager {
  // Sign Up Screen Keys
  static final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Sign In Screen Keys
  static final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  // OTP Verification Screen Keys
  static final GlobalKey<FormState> otpVerificationFormKey =
      GlobalKey<FormState>();

  // Password Screen Keys
  static final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  // Forgot Password Screen Keys
  static final GlobalKey<FormState> forgotPasswordFormKey =
      GlobalKey<FormState>();

  // Create Profile Screen Keys
  static final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  // Add more keys for other screens as needed
}
