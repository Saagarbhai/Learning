import '../utils/app_export.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppConstants.onboardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppConstants.welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppConstants.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppConstants.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case AppConstants.otpVerificationRoute:
        return MaterialPageRoute(builder: (_) => const OtpVerificationScreen());
      case AppConstants.passwordRoute:
        return MaterialPageRoute(builder: (_) => const PasswordScreen());
      case AppConstants.createProfileRoute:
        return MaterialPageRoute(builder: (_) => const CreateProfileScreen());
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
