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
      PasswordSubmitted event, Emitter<PasswordState> emit) {
    // Validate the password first
    if (!state.isPasswordValid) {
      emit(state.copyWith(
        errorMessage:
            'Password must contain at least one number or special character',
      ));
      return;
    }

    // Then validate the confirmation password
    if (!state.isConfirmPasswordValid) {
      emit(state.copyWith(
        errorMessage: 'Passwords do not match',
      ));
      return;
    }

    // If both validations pass, proceed with submission
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      ));
    });
  }
}
