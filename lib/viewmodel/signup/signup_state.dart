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
  final GlobalKey<FormState> formKey;
  final List<String> genders;
  final String? selectedGender;

  SignUpState({
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
    GlobalKey<FormState>? formKey,
    List<String>? genders,
    this.selectedGender,
  })  : this.formKey = formKey ?? KeysManager.createSignUpFormKey(),
        this.genders = genders ?? ['Male', 'Female', 'Other'];

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
    String? selectedGender,
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
      formKey: formKey,
      genders: genders,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }

  bool get isFormValid {
    // Use validator utilities
    final bool isNameValid = name != null && name!.isNotEmpty;
    final bool isEmailValid = email != null && email!.isNotEmpty
        ? Validators.isEmailValid(email!)
        : false;
    final bool isPhoneValid = phoneNumber != null && phoneNumber!.isNotEmpty
        ? Validators.isPhoneValid(phoneNumber!)
        : false;
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
        nameController,
        emailController,
        phoneController,
        formKey,
        genders,
        selectedGender,
      ];
}
