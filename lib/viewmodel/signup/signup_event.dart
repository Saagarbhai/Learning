import 'package:learning/core/utils/app_export.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class UpdateSelectedGender extends SignUpEvent {
  final String gender;

  const UpdateSelectedGender({required this.gender});

  @override
  List<Object> get props => [gender];
}

class SignUpFormChanged extends SignUpEvent {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? gender;

  const SignUpFormChanged({
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
  });

  @override
  List<Object?> get props => [name, email, phoneNumber, gender];
}

class SignUpWithEmailAndPassword extends SignUpEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String gender;

  const SignUpWithEmailAndPassword({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  });

  @override
  List<Object> get props => [name, email, phoneNumber, gender];
}

class SignUpWithGmail extends SignUpEvent {}

class SignUpWithFacebook extends SignUpEvent {}

class SignUpWithApple extends SignUpEvent {}

class NavigateToSignIn extends SignUpEvent {}

class InitializeSignUp extends SignUpEvent {}

class DisposeSignUp extends SignUpEvent {}
