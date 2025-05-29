import 'package:learning/core/utils/app_export.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class SignUpFormValidationState extends SignUpState {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final bool isFormValid;

  const SignUpFormValidationState({
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.isFormValid = false,
  });

  SignUpFormValidationState copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    bool? isFormValid,
  }) {
    return SignUpFormValidationState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [name, email, phoneNumber, gender, isFormValid];
}
