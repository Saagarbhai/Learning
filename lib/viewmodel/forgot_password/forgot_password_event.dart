import 'package:learning/core/utils/app_export.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class VerificationInputChanged extends ForgotPasswordEvent {
  final String input;

  const VerificationInputChanged({required this.input});

  @override
  List<Object?> get props => [input];
}

class SendOtpPressed extends ForgotPasswordEvent {}

class ResetForgotPasswordState extends ForgotPasswordEvent {}

class InitializeForgotPassword extends ForgotPasswordEvent {}

class DisposeForgotPassword extends ForgotPasswordEvent {}
