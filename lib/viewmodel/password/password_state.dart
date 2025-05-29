import '../../core/utils/app_export.dart';

class PasswordState extends Equatable {
  final String password;
  final String confirmPassword;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const PasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  PasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return PasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        password,
        confirmPassword,
        isPasswordValid,
        isConfirmPasswordValid,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}
