import '../../core/utils/app_export.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordState.initial()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<PasswordSubmitted>(_onPasswordSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ResetPasswordValidation>(_onResetPasswordValidation);
    on<InitializePassword>(_onInitializePassword);
    on<DisposePassword>(_onDisposePassword);

    // Initialize controller listeners
    state.passwordController.addListener(_passwordControllerListener);
    state.confirmPasswordController
        .addListener(_confirmPasswordControllerListener);
  }

  void _passwordControllerListener() {
    add(PasswordChanged(state.passwordController.text));
  }

  void _confirmPasswordControllerListener() {
    add(ConfirmPasswordChanged(state.confirmPasswordController.text));
  }

  void _onInitializePassword(
      InitializePassword event, Emitter<PasswordState> emit) {
    // No need to do anything as controllers are already initialized in constructor
  }

  void _onDisposePassword(DisposePassword event, Emitter<PasswordState> emit) {
    // Don't dispose controllers here, they will be disposed in close()
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<PasswordState> emit) {
    final password = event.password;
    // Use the validator utility
    final isPasswordValid = Validators.isPasswordValid(password);

    debugPrint('Password: $password, Valid: $isPasswordValid');

    emit(state.copyWith(
      password: password,
      isPasswordValid: isPasswordValid,
      errorMessage: null, // Clear previous error messages
    ));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<PasswordState> emit) {
    final confirmPassword = event.confirmPassword;
    final isConfirmPasswordValid = confirmPassword == state.password;

    debugPrint(
        'Confirm Password: $confirmPassword, Match: $isConfirmPasswordValid');

    emit(state.copyWith(
      confirmPassword: confirmPassword,
      isConfirmPasswordValid: isConfirmPasswordValid,
      errorMessage: null, // Clear previous error messages
    ));
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<PasswordState> emit) {
    if (event.isConfirmField) {
      emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
      ));
    } else {
      emit(state.copyWith(
        isPasswordVisible: !state.isPasswordVisible,
      ));
    }
  }

  void _onResetPasswordValidation(
      ResetPasswordValidation event, Emitter<PasswordState> emit) {
    debugPrint(
        'Before reset - Password: ${state.password}, isPasswordValid: ${state.isPasswordValid}, confirmPassword: ${state.confirmPassword}, isConfirmPasswordValid: ${state.isConfirmPasswordValid}');

    // Update the controllers too
    state.passwordController.text = '';
    state.confirmPasswordController.text = '';

    final newState = state.copyWith(
      isPasswordValid: false,
      isConfirmPasswordValid: false,
      password: '',
      confirmPassword: '',
      isSuccess: false, // Reset success state too
    );

    emit(newState);

    debugPrint(
        'After reset - Password: ${newState.password}, isPasswordValid: ${newState.isPasswordValid}, confirmPassword: ${newState.confirmPassword}, isConfirmPasswordValid: ${newState.isConfirmPasswordValid}');
  }

  void _onPasswordSubmitted(
      PasswordSubmitted event, Emitter<PasswordState> emit) async {
    debugPrint(
        'Password Submission: Password valid: ${state.isPasswordValid}, Confirm valid: ${state.isConfirmPasswordValid}');

    // Validate the password first
    if (!state.isPasswordValid) {
      emit(state.copyWith(
        errorMessage:
            'Password must contain at least one number or special character',
      ));
      debugPrint('Password validation failed: ${state.errorMessage}');
      return;
    }

    // Then validate the confirmation password
    if (!state.isConfirmPasswordValid) {
      emit(state.copyWith(
        errorMessage: 'Passwords do not match',
      ));
      debugPrint('Confirm password validation failed: ${state.errorMessage}');
      return;
    }

    // If both validations pass, proceed with submission
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    debugPrint('Password submission in progress...');

    // Simulate API call with async/await pattern
    try {
      //await Future.delayed(const Duration(seconds: 1));

      debugPrint(
          'Before success state update - Password: ${state.password}, isPasswordValid: ${state.isPasswordValid}, confirmPassword: ${state.confirmPassword}, isConfirmPasswordValid: ${state.isConfirmPasswordValid}');

      // Clear controller text
      state.passwordController.text = '';
      state.confirmPasswordController.text = '';

      // This emit will now properly update the state
      final newState = state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        // Reset validation state on success
        isPasswordValid: false,
        isConfirmPasswordValid: false,
        password: '',
        confirmPassword: '',
      );

      emit(newState);

      debugPrint(
          'After success state update - Password: ${newState.password}, isPasswordValid: ${newState.isPasswordValid}, confirmPassword: ${newState.confirmPassword}, isConfirmPasswordValid: ${newState.isConfirmPasswordValid}');
      debugPrint(
          'Password submission successful, isSuccess: true, validation state reset');
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'An error occurred during submission',
      ));
      debugPrint('Password submission failed: $e');
    }
  }

  @override
  Future<void> close() {
    // Remove listeners
    state.passwordController.removeListener(_passwordControllerListener);
    state.confirmPasswordController
        .removeListener(_confirmPasswordControllerListener);

    // Dispose controllers
    state.passwordController.dispose();
    state.confirmPasswordController.dispose();

    return super.close();
  }
}
