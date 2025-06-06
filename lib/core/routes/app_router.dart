import '../utils/app_export.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppConstants.onboardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppConstants.welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppConstants.signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case AppConstants.signInRoute:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case AppConstants.otpVerificationRoute:
        return MaterialPageRoute(builder: (_) => OtpVerificationScreen());
      case AppConstants.passwordRoute:
        return MaterialPageRoute(builder: (_) => PasswordScreen());
      case AppConstants.createProfileRoute:
        return MaterialPageRoute(builder: (_) => CreateProfileScreen());
      case AppConstants.forgotPasswordVerificationRoute:
        return MaterialPageRoute(
            builder: (_) => ForgotPasswordVerificationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
