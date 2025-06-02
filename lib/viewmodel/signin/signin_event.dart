import '../../core/utils/app_export.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInWithEmailPasswordPressed extends SignInEvent {
  final String email;
  final String password;

  const SignInWithEmailPasswordPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignInWithGmailPressed extends SignInEvent {}

class SignInWithFacebookPressed extends SignInEvent {}

class SignInWithApplePressed extends SignInEvent {}

class ForgotPasswordPressed extends SignInEvent {}

class NavigateToSignUpPressed extends SignInEvent {}

class UpdateEmail extends SignInEvent {
  final String email;

  const UpdateEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdatePassword extends SignInEvent {
  final String password;

  const UpdatePassword(this.password);

  @override
  List<Object?> get props => [password];
}

class ToggleSignInPasswordVisibility extends SignInEvent {}

class ResetSignInState extends SignInEvent {}

class InitializeSignIn extends SignInEvent {}

class DisposeSignIn extends SignInEvent {}
