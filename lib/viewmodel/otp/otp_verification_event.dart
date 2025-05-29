import 'package:learning/core/utils/app_export.dart';

abstract class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();

  @override
  List<Object?> get props => [];
}

class OtpChanged extends OtpVerificationEvent {
  final String otp;

  const OtpChanged({required this.otp});

  @override
  List<Object> get props => [otp];
}

class VerifyOtp extends OtpVerificationEvent {
  final String otp;

  const VerifyOtp({required this.otp});

  @override
  List<Object> get props => [otp];
}

class ResendOtp extends OtpVerificationEvent {}
