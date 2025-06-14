import '../../core/utils/app_export.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if we're coming from logout and reset all relevant blocs
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final wasLoggedOut = prefs.getBool('was_logged_out') ?? false;

      if (wasLoggedOut) {
        // Reset all relevant blocs to ensure no data persists
        context.read<SignUpBloc>().add(InitializeSignUp());
        context.read<ProfileBloc>().add(ResetProfile());

        // Reset the flag
        await prefs.setBool('was_logged_out', false);
      }
    });

    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF8F9FA),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              children: [
                // Status bar spacing
                SizedBox(height: 20.h),

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
                        SizedBox(height: 30.h),
                        Text(
                          Lang.of(context).welcome,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          Lang.of(context).welcomeDescription,
                          style: TextStyle(
                            fontSize: 16.sp,
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
                          Navigator.of(context).pushNamed(
                            AppConstants.signUpRoute,
                          );
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Log in button
                      CustomButton(
                        text: Lang.of(context).welcomebutton2,
                        width: double.infinity,
                        isPrimary: false,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppConstants.signInRoute,
                          );
                          // context.read<WelcomeBloc>().add(LogInPressed());
                        },
                      ),
                      SizedBox(height: 16.h),
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
