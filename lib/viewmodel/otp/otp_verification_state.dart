import 'package:learning/core/utils/app_export.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object?> get props => [];
}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpVerificationSuccess extends OtpVerificationState {}

class OtpResendSuccess extends OtpVerificationState {}

class OtpVerificationFailure extends OtpVerificationState {
  final String error;

  const OtpVerificationFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class OtpFormValidationState extends OtpVerificationState {
  final String otp;
  final bool isFormValid;

  const OtpFormValidationState({
    this.otp = '',
    this.isFormValid = false,
  });

  OtpFormValidationState copyWith({
    String? otp,
    bool? isFormValid,
  }) {
    return OtpFormValidationState(
      otp: otp ?? this.otp,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  bool isOtpCorrect() {
    return otp == '12345';
  }

  @override
  List<Object?> get props => [otp, isFormValid];
}
