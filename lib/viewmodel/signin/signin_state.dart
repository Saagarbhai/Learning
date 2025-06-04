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
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final UserData? userData;
  final String? token;

  SignInState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
    this.isSignInSuccess = false,
    this.navigateToSignUp = false,
    this.navigateToForgotPassword = false,
    required this.emailController,
    required this.passwordController,
    this.userData,
    this.token,
  });

  factory SignInState.initial() {
    return SignInState(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isLoading,
    String? errorMessage,
    bool? isSignInSuccess,
    bool? navigateToSignUp,
    bool? navigateToForgotPassword,
    UserData? userData,
    String? token,
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
      emailController: emailController,
      passwordController: passwordController,
      userData: userData ?? this.userData,
      token: token ?? this.token,
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
        userData,
        token,
      ];
}
