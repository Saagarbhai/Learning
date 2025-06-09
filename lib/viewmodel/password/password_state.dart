import '../../core/utils/app_export.dart';

class PasswordState extends Equatable {
  final String password;
  final String confirmPassword;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  PasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
  })  : this.passwordController = passwordController ?? TextEditingController(),
        this.confirmPasswordController =
            confirmPasswordController ?? TextEditingController();

  factory PasswordState.initial() {
    return PasswordState(
      passwordController: TextEditingController(),
      confirmPasswordController: TextEditingController(),
    );
  }

  PasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
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
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
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
        isPasswordVisible,
        isConfirmPasswordVisible,
        // Don't include controllers in props to avoid unnecessary rebuilds
      ];
}
