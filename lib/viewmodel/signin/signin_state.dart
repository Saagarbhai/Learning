import '../../core/utils/app_export.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isLoading;
  final String? errorMessage;
  final bool isSignInSuccess;
  final bool navigateToSignUp;
  final bool navigateToForgotPassword;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  SignInState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
    this.isSignInSuccess = false,
    this.navigateToSignUp = false,
    this.navigateToForgotPassword = false,
    GlobalKey<FormState>? formKey,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  })  : formKey = formKey ?? GlobalKey<FormState>(),
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isLoading,
    String? errorMessage,
    bool? isSignInSuccess,
    bool? navigateToSignUp,
    bool? navigateToForgotPassword,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSignInSuccess: isSignInSuccess ?? this.isSignInSuccess,
      navigateToSignUp: navigateToSignUp ?? this.navigateToSignUp,
      navigateToForgotPassword:
          navigateToForgotPassword ?? this.navigateToForgotPassword,
      formKey: formKey,
      emailController: emailController,
      passwordController: passwordController,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isPasswordVisible,
        isLoading,
        errorMessage,
        isSignInSuccess,
        navigateToSignUp,
        navigateToForgotPassword,
      ];
}
