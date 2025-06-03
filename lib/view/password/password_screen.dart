import '../../core/utils/app_export.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  // Method to navigate to profile screen
  void _navigateToProfileScreen(BuildContext context) {
    print('Navigating to CreateProfileScreen');
    Navigator.of(context).pushReplacementNamed(AppConstants.createProfileRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const CustomBackButton(),
        actions: [
          LanguageButton(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocListener<PasswordBloc, PasswordState>(
            // listenWhen: (previous, current) =>
            //     previous.isSuccess != current.isSuccess ||
            //     previous.errorMessage != current.errorMessage,
            listener: (context, state) {
              print(
                  'BlocListener: isSuccess: ${state.isSuccess}, errorMessage: ${state.errorMessage}');
              if (state.isSuccess) {
                print('Navigation triggered: going to CreateProfileScreen');
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(Lang.of(context).passwordsetsuccessfully),
                    duration: const Duration(seconds: 1),
                  ),
                );
                // Navigate to create profile screen with a small delay to allow the snackbar to be seen
                Future.delayed(const Duration(milliseconds: 200), () {
                  _navigateToProfileScreen(context);
                });
              }
              if (state.errorMessage != null) {
                print('Error message shown: ${state.errorMessage}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            child: BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
                return Form(
                  key: context.read<PasswordBloc>().formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      // Header text
                      Text(
                        Lang.of(context).setPassword,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        Lang.of(context).setYourPassword,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 32.h),
                      // Password fields
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Password field
                              BlocBuilder<PasswordBloc, PasswordState>(
                                buildWhen: (previous, current) =>
                                    previous.password != current.password,
                                builder: (context, state) {
                                  return CustomPasswordField(
                                    hintText: Lang.of(context).hintPassword,
                                    isValid: state.isPasswordValid,
                                    onChanged: (value) {
                                      context
                                          .read<PasswordBloc>()
                                          .add(PasswordChanged(value));
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 16.h),
                              // Confirm password field
                              BlocBuilder<PasswordBloc, PasswordState>(
                                buildWhen: (previous, current) =>
                                    previous.confirmPassword !=
                                        current.confirmPassword ||
                                    previous.isConfirmPasswordValid !=
                                        current.isConfirmPasswordValid,
                                builder: (context, state) {
                                  return CustomPasswordField(
                                    hintText: Lang.of(context).confirmPassword,
                                    confirmField: true,
                                    isConfirmMatch:
                                        state.isConfirmPasswordValid,
                                    onChanged: (value) {
                                      context
                                          .read<PasswordBloc>()
                                          .add(ConfirmPasswordChanged(value));
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 8.h),
                              // Password requirements text
                              Text(
                                Lang.of(context).passwordDescription,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Register button at the bottom of the screen
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0, top: 12.0),
                        child: BlocBuilder<PasswordBloc, PasswordState>(
                          buildWhen: (previous, current) =>
                              previous.isPasswordValid !=
                                  current.isPasswordValid ||
                              previous.isConfirmPasswordValid !=
                                  current.isConfirmPasswordValid ||
                              previous.isSubmitting != current.isSubmitting,
                          builder: (context, state) {
                            final bool canSubmit = state.isPasswordValid &&
                                state.isConfirmPasswordValid &&
                                !state.isSubmitting;

                            return CustomButton(
                              text: Lang.of(context).register,
                              onPressed: canSubmit
                                  ? () {
                                      print(
                                          'Register button pressed, submitting password');
                                      context
                                          .read<PasswordBloc>()
                                          .add(PasswordSubmitted());
                                    }
                                  : null,
                              width: double.infinity,
                              height: 50.h,
                              isLoading: state.isSubmitting,
                              showShadow: true,
                              backgroundColor: canSubmit
                                  ? const Color(0xFF039855)
                                  : Colors.grey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              borderRadius: 8.r,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
