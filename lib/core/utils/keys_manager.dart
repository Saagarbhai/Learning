import 'package:flutter/material.dart';

/// A centralized manager for all GlobalKeys used across the application.
/// Using factory methods to create new GlobalKey instances each time they're needed,
/// avoiding the "Multiple widgets used the same GlobalKey" error.
class KeysManager {
  // Private constructor to prevent instantiation
  KeysManager._();

  // Factory methods for each form key
  static GlobalKey<FormState> createSignUpFormKey() => GlobalKey<FormState>();

  static GlobalKey<FormState> createSignInFormKey() => GlobalKey<FormState>();

  static GlobalKey<FormState> createOtpVerificationFormKey() =>
      GlobalKey<FormState>();

  static GlobalKey<FormState> createPasswordFormKey() => GlobalKey<FormState>();

  static GlobalKey<FormState> createForgotPasswordFormKey() =>
      GlobalKey<FormState>();

  static GlobalKey<FormState> createProfileFormKey() => GlobalKey<FormState>();

  // Add more factory methods for other screens as needed
}
