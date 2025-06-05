import 'package:learning/core/utils/app_export.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;

  const SignUpInitial({
    this.nameController,
    this.emailController,
    this.phoneController,
  });

  @override
  List<Object?> get props => [nameController, emailController, phoneController];
}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class NavigateToSignInState extends SignUpState {}

class SignUpFormValidationState extends SignUpState {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final bool isFormValid;
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;

  const SignUpFormValidationState({
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.isFormValid = false,
    this.nameController,
    this.emailController,
    this.phoneController,
  });

  SignUpFormValidationState copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    bool? isFormValid,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
  }) {
    return SignUpFormValidationState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      isFormValid: isFormValid ?? this.isFormValid,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        gender,
        isFormValid,
        nameController,
        emailController,
        phoneController,
      ];
}
