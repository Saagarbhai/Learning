import 'package:learning/core/utils/app_export.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc() : super(OtpVerificationState()) {
    on<OtpChanged>(_onOtpChanged);
    on<VerifyOtp>(_onVerifyOtp);
    on<ResendOtp>(_onResendOtp);

    // Setup initial state
    add(const OtpChanged(otp: ''));
  }

  void _onOtpChanged(
    OtpChanged event,
    Emitter<OtpVerificationState> emit,
  ) {
    final currentOtp = event.otp;
    final bool isComplete = currentOtp.length == 5;

    emit(state.copyWith(
      status: OtpVerificationStatus.formValidation,
      otp: currentOtp,
      isFormValid: isComplete,
    ));
  }

  void _onVerifyOtp(
    VerifyOtp event,
    Emitter<OtpVerificationState> emit,
  ) async {
    emit(state.copyWith(status: OtpVerificationStatus.loading));

    try {
      // Here you would typically make an API call to verify the OTP
      // For now, we'll just simulate a verification process
      //  await Future.delayed(const Duration(seconds: 2));

      // Check if OTP is correct (12345)
      if (event.otp == '12345') {
        // Clear the pin input on success
        state.pinController.clear();
        emit(state.copyWith(status: OtpVerificationStatus.success));
      } else {
        emit(state.copyWith(
          status: OtpVerificationStatus.failure,
          errorMessage: 'Invalid OTP. Please try again.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: OtpVerificationStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onResendOtp(
    ResendOtp event,
    Emitter<OtpVerificationState> emit,
  ) async {
    emit(state.copyWith(status: OtpVerificationStatus.resendLoading));

    try {
      // Simulate resending OTP
      // await Future.delayed(const Duration(seconds: 1));

      // Clear the pin input when resending OTP
      state.pinController.clear();

      // Show resend OTP success notification
      emit(state.copyWith(status: OtpVerificationStatus.resendSuccess));

      // Reset form validation state
      add(const OtpChanged(otp: ''));
    } catch (e) {
      emit(state.copyWith(
        status: OtpVerificationStatus.resendFailure,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    // Dispose controller
    state.pinController.dispose();
    return super.close();
  }
}
