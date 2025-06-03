import 'package:learning/core/utils/app_export.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  // Use the key from KeysManager
  final formKey = KeysManager.forgotPasswordFormKey;

  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<VerificationInputChanged>(_onVerificationInputChanged);
    on<SendOtpPressed>(_onSendOtpPressed);
    on<ResetForgotPasswordState>(_onResetForgotPasswordState);
    on<InitializeForgotPassword>(_onInitializeForgotPassword);
    on<DisposeForgotPassword>(_onDisposeForgotPassword);

    // Initialize controller listener
    state.inputController.addListener(_inputControllerListener);
  }

  void _inputControllerListener() {
    add(VerificationInputChanged(input: state.inputController.text));
  }

  void _onInitializeForgotPassword(
      InitializeForgotPassword event, Emitter<ForgotPasswordState> emit) {
    // No need to do anything as controller is already initialized in constructor
  }

  void _onDisposeForgotPassword(
      DisposeForgotPassword event, Emitter<ForgotPasswordState> emit) {
    state.inputController.removeListener(_inputControllerListener);
    state.inputController.dispose();
  }

  void _onVerificationInputChanged(
      VerificationInputChanged event, Emitter<ForgotPasswordState> emit) {
    final input = event.input;

    // Validate input - can be either email or phone number
    final bool isEmail =
        RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$').hasMatch(input);
    final bool isPhone = RegExp(r'^\d{10}$').hasMatch(input);
    final bool isInputValid = isEmail || isPhone;

    emit(state.copyWith(
      verificationInput: input,
      isInputValid: isInputValid,
      errorMessage: null, // Clear previous error messages
    ));
  }

  Future<void> _onSendOtpPressed(
      SendOtpPressed event, Emitter<ForgotPasswordState> emit) async {
    if (!state.isInputValid) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid email or phone number',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, always succeed
      emit(state.copyWith(isLoading: false, isOtpSent: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onResetForgotPasswordState(
      ResetForgotPasswordState event, Emitter<ForgotPasswordState> emit) {
    emit(ForgotPasswordState());
  }

  @override
  Future<void> close() {
    state.inputController.removeListener(_inputControllerListener);
    state.inputController.dispose();
    return super.close();
  }
}
