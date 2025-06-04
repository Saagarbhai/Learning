// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Lang {
  Lang();

  static Lang? _current;

  static Lang get current {
    assert(
      _current != null,
      'No instance of Lang was loaded. Try to initialize the Lang delegate before accessing Lang.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Lang> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Lang();
      Lang._current = instance;

      return instance;
    });
  }

  static Lang of(BuildContext context) {
    final instance = Lang.maybeOf(context);
    assert(
      instance != null,
      'No instance of Lang present in the widget tree. Did you add Lang.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static Lang? maybeOf(BuildContext context) {
    return Localizations.of<Lang>(context, Lang);
  }

  /// `Car App`
  String get apptitle {
    return Intl.message('Car App', name: 'apptitle', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Onboarding`
  String get onboardingScreenTitle {
    return Intl.message(
      'Onboarding',
      name: 'onboardingScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Onboarding Completed!`
  String get completed {
    return Intl.message(
      'Onboarding Completed!',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Welcome to Car App`
  String get onboardingData1Title {
    return Intl.message(
      'Welcome to Car App',
      name: 'onboardingData1Title',
      desc: '',
      args: [],
    );
  }

  /// `Find and book cars near you with just a few taps`
  String get onboardingData1Description {
    return Intl.message(
      'Find and book cars near you with just a few taps',
      name: 'onboardingData1Description',
      desc: '',
      args: [],
    );
  }

  /// `Easy Booking`
  String get onboardingData2Title {
    return Intl.message(
      'Easy Booking',
      name: 'onboardingData2Title',
      desc: '',
      args: [],
    );
  }

  /// `Book your ride anytime, anywhere with our simple interface`
  String get onboardingData2Description {
    return Intl.message(
      'Book your ride anytime, anywhere with our simple interface',
      name: 'onboardingData2Description',
      desc: '',
      args: [],
    );
  }

  /// `Fast & Reliable`
  String get onboardingData3Title {
    return Intl.message(
      'Fast & Reliable',
      name: 'onboardingData3Title',
      desc: '',
      args: [],
    );
  }

  /// `Get to your destination quickly with our trusted drivers`
  String get onboardingData3Description {
    return Intl.message(
      'Get to your destination quickly with our trusted drivers',
      name: 'onboardingData3Description',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Have a better sharing experience`
  String get welcomeDescription {
    return Intl.message(
      'Have a better sharing experience',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get welcomebutton1 {
    return Intl.message(
      'Create an account',
      name: 'welcomebutton1',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get welcomebutton2 {
    return Intl.message('Log in', name: 'welcomebutton2', desc: '', args: []);
  }

  /// `Sign up successful!`
  String get signupSuccessful {
    return Intl.message(
      'Sign up successful!',
      name: 'signupSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Sign up failed`
  String get signupFail {
    return Intl.message(
      'Sign up failed',
      name: 'signupFail',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Sign up with your email or phone number`
  String get signupInfo {
    return Intl.message(
      'Sign up with your email or phone number',
      name: 'signupInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Email`
  String get hintEmail {
    return Intl.message('Email', name: 'hintEmail', desc: '', args: []);
  }

  /// `Your Mobile Number`
  String get hintPhone {
    return Intl.message(
      'Your Mobile Number',
      name: 'hintPhone',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get hintGender {
    return Intl.message('Gender', name: 'hintGender', desc: '', args: []);
  }

  /// `By signing up, you agree to the `
  String get signTextSpan1 {
    return Intl.message(
      'By signing up, you agree to the ',
      name: 'signTextSpan1',
      desc: '',
      args: [],
    );
  }

  /// `Terms of service`
  String get signTextSpan2 {
    return Intl.message(
      'Terms of service',
      name: 'signTextSpan2',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get signTextSpan3 {
    return Intl.message(' and ', name: 'signTextSpan3', desc: '', args: []);
  }

  /// `Privacy policy`
  String get signTextSpan4 {
    return Intl.message(
      'Privacy policy',
      name: 'signTextSpan4',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signupButton {
    return Intl.message('Sign Up', name: 'signupButton', desc: '', args: []);
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Sign up with Gmail`
  String get signupwithGmail {
    return Intl.message(
      'Sign up with Gmail',
      name: 'signupwithGmail',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with FaceBook`
  String get signupwithFaceBook {
    return Intl.message(
      'Sign up with FaceBook',
      name: 'signupwithFaceBook',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Apple`
  String get signupwithApple {
    return Intl.message(
      'Sign up with Apple',
      name: 'signupwithApple',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Phone verification`
  String get phoneVerification {
    return Intl.message(
      'Phone verification',
      name: 'phoneVerification',
      desc: '',
      args: [],
    );
  }

  /// `Enter your OTP code`
  String get enterOtpCode {
    return Intl.message(
      'Enter your OTP code',
      name: 'enterOtpCode',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive code? `
  String get didntReceiveCode {
    return Intl.message(
      'Didn\'t receive code? ',
      name: 'didntReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend again`
  String get resendAgain {
    return Intl.message(
      'Resend again',
      name: 'resendAgain',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Verification successful!`
  String get verificationSuccessful {
    return Intl.message(
      'Verification successful!',
      name: 'verificationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `OTP code resent successfully!`
  String get otpResent {
    return Intl.message(
      'OTP code resent successfully!',
      name: 'otpResent',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful!`
  String get registrationSuccessful {
    return Intl.message(
      'Registration successful!',
      name: 'registrationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get setPassword {
    return Intl.message(
      'Set Password',
      name: 'setPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set Your Password`
  String get setYourPassword {
    return Intl.message(
      'Set Your Password',
      name: 'setYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Atleast 1 number or a special character`
  String get passwordDescription {
    return Intl.message(
      'Atleast 1 number or a special character',
      name: 'passwordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Password set successfully!`
  String get passwordsetsuccessfully {
    return Intl.message(
      'Password set successfully!',
      name: 'passwordsetsuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get hintPassword {
    return Intl.message(
      'Enter Your Password',
      name: 'hintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Street`
  String get street {
    return Intl.message('Street', name: 'street', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Profile created successfully!`
  String get profilecreatedsuccesfully {
    return Intl.message(
      'Profile created successfully!',
      name: 'profilecreatedsuccesfully',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `District`
  String get district {
    return Intl.message('District', name: 'district', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Verification email or phone number`
  String get verificationEmailorPhone {
    return Intl.message(
      'Verification email or phone number',
      name: 'verificationEmailorPhone',
      desc: '',
      args: [],
    );
  }

  /// `Email or phone number`
  String get hintEmailofPhone {
    return Intl.message(
      'Email or phone number',
      name: 'hintEmailofPhone',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOTP {
    return Intl.message('Send OTP', name: 'sendOTP', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Do not have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Do not have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Lang> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'gu'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Lang> load(Locale locale) => Lang.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
