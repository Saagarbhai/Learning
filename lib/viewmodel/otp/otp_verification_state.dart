import 'package:learning/core/utils/app_export.dart';

enum OtpVerificationStatus {
  initial,
  loading,
  success,
  failure,
  formValidation,
  resendLoading,
  resendSuccess,
  resendFailure,
}

class OtpVerificationState extends Equatable {
  final OtpVerificationStatus status;
  final String otp;
  final bool isFormValid;
  final String? errorMessage;
  final TextEditingController pinController;

  OtpVerificationState({
    this.status = OtpVerificationStatus.initial,
    this.otp = '',
    this.isFormValid = false,
    this.errorMessage,
    TextEditingController? pinController,
  }) : this.pinController = pinController ?? TextEditingController();

  OtpVerificationState copyWith({
    OtpVerificationStatus? status,
    String? otp,
    bool? isFormValid,
    String? errorMessage,
  }) {
    return OtpVerificationState(
      status: status ?? this.status,
      otp: otp ?? this.otp,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage,
      pinController: pinController,
    );
  }

  bool isOtpCorrect() {
    return otp == '12345';
  }

  @override
  List<Object?> get props =>
      [status, otp, isFormValid, errorMessage, pinController];
}
