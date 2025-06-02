import 'package:learning/core/utils/app_export.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  // Controllers for OTP verification
  final List<TextEditingController> otpControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(
    5,
    (_) => FocusNode(),
  );

  // Pin controller for CustomPinBox
  final TextEditingController pinController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  OtpVerificationBloc() : super(OtpVerificationInitial()) {
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

    if (state is OtpFormValidationState) {
      final currentState = state as OtpFormValidationState;
      final updatedState = currentState.copyWith(
        otp: currentOtp,
        isFormValid: isComplete,
      );
      emit(updatedState);
    } else {
      emit(OtpFormValidationState(
        otp: currentOtp,
        isFormValid: isComplete,
      ));
    }
  }

  void _onVerifyOtp(
    VerifyOtp event,
    Emitter<OtpVerificationState> emit,
  ) async {
    emit(OtpVerificationLoading());

    try {
      // Here you would typically make an API call to verify the OTP
      // For now, we'll just simulate a verification process
      await Future.delayed(const Duration(seconds: 2));

      // Check if OTP is correct (12345)
      if (event.otp == '12345') {
        // Clear the pin input on success
        pinController.clear();
        emit(OtpVerificationSuccess());
      } else {
        emit(const OtpVerificationFailure(
            error: 'Invalid OTP. Please try again.'));
      }
    } catch (e) {
      emit(OtpVerificationFailure(error: e.toString()));
    }
  }

  void _onResendOtp(
    ResendOtp event,
    Emitter<OtpVerificationState> emit,
  ) async {
    try {
      // Simulate resending OTP
      await Future.delayed(const Duration(seconds: 1));

      // Reset form validation state
      add(const OtpChanged(otp: ''));

      // Clear the pin input when resending OTP
      pinController.clear();

      // Show resend OTP success notification
      emit(OtpResendSuccess());

      // Restore the validation state
      await Future.delayed(const Duration(milliseconds: 100));
      add(const OtpChanged(otp: ''));
    } catch (e) {
      emit(OtpVerificationFailure(error: e.toString()));
    }
  }

  // Helper method to get combined OTP
  String getCombinedOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }

  @override
  Future<void> close() {
    // Dispose controllers and focus nodes when bloc is closed
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    pinController.dispose();
    return super.close();
  }
}
