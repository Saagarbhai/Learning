import '../../core/utils/app_export.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) {
        if (state is NavigateToCreateAccount) {
          // Always navigate to a fresh instance of SignUpScreen
          Navigator.of(context)
              .pushNamed(
            AppConstants.signUpRoute,
          )
              .then((_) {
            // Reset the bloc state when returning from sign-up screen
            context.read<WelcomeBloc>().add(ResetWelcomeState());
          });
        } else if (state is NavigateToLogin) {
          // Navigate to login screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to Login')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF8F9FA),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Status bar spacing
                const SizedBox(height: 20),

                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          child: SvgPicture.asset(
                              Assets.images.welcomeScreenImage.welcome1.path),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          Lang.of(context).welcome,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          Lang.of(context).welcomeDescription,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Buttons section
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Create account button
                      CustomButton(
                        text: Lang.of(context).welcomebutton1,
                        width: double.infinity,
                        onPressed: () {
                          context
                              .read<WelcomeBloc>()
                              .add(CreateAccountPressed());
                        },
                      ),
                      const SizedBox(height: 16),

                      // Log in button
                      CustomButton(
                        text: Lang.of(context).welcomebutton2,
                        width: double.infinity,
                        isPrimary: false,
                        onPressed: () {
                          context.read<WelcomeBloc>().add(LogInPressed());
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
