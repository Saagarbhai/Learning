import 'package:learning/core/utils/app_export.dart';

class SignUpState extends Equatable {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final bool isLoading;
  final String? errorMessage;
  final bool isSignUpSuccess;
  final bool navigateToSignIn;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const SignUpState({
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.gender,
    this.isLoading = false,
    this.errorMessage,
    this.isSignUpSuccess = false,
    this.navigateToSignIn = false,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  factory SignUpState.initial() {
    return SignUpState(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
    );
  }

  SignUpState copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    bool? isLoading,
    String? errorMessage,
    bool? isSignUpSuccess,
    bool? navigateToSignIn,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSignUpSuccess: isSignUpSuccess ?? this.isSignUpSuccess,
      navigateToSignIn: navigateToSignIn ?? this.navigateToSignIn,
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
    );
  }

  bool get isFormValid {
    // Simple validation
    final bool isNameValid = name != null && name!.isNotEmpty;
    final bool isEmailValid = email != null &&
        RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$').hasMatch(email!);
    final bool isPhoneValid = phoneNumber != null && phoneNumber!.isNotEmpty;
    final bool isGenderValid = gender != null && gender!.isNotEmpty;

    return isNameValid && (isEmailValid || isPhoneValid) && isGenderValid;
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        gender,
        isLoading,
        errorMessage,
        isSignUpSuccess,
        navigateToSignIn,
      ];
}
