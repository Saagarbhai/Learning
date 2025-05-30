import '../../core/utils/app_export.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<PasswordSubmitted>(_onPasswordSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<PasswordState> emit) {
    final password = event.password;
    // Password validation: At least 1 number or special character
    final isPasswordValid = password.length >= 6 &&
        (RegExp(r'[0-9]').hasMatch(password) ||
            RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password));

    print('Password: $password, Valid: $isPasswordValid');

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

    print('Confirm Password: $confirmPassword, Match: $isConfirmPasswordValid');

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

  void _onPasswordSubmitted(
      PasswordSubmitted event, Emitter<PasswordState> emit) async {
    print(
        'Password Submission: Password valid: ${state.isPasswordValid}, Confirm valid: ${state.isConfirmPasswordValid}');

    // Validate the password first
    if (!state.isPasswordValid) {
      emit(state.copyWith(
        errorMessage:
            'Password must contain at least one number or special character',
      ));
      print('Password validation failed: ${state.errorMessage}');
      return;
    }

    // Then validate the confirmation password
    if (!state.isConfirmPasswordValid) {
      emit(state.copyWith(
        errorMessage: 'Passwords do not match',
      ));
      print('Confirm password validation failed: ${state.errorMessage}');
      return;
    }

    // If both validations pass, proceed with submission
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    print('Password submission in progress...');

    // Simulate API call with async/await pattern
    try {
      await Future.delayed(const Duration(seconds: 1));

      // This emit will now properly update the state
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      ));

      print('Password submission successful, isSuccess: true');
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'An error occurred during submission',
      ));
      print('Password submission failed: $e');
    }
  }
}
