import '../../core/utils/app_export.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Method to navigate to profile screen
  void _navigateToProfileScreen(BuildContext context) {
    debugPrint('Navigating to CreateProfileScreen');

    // Reset password validation state before navigating
    context.read<PasswordBloc>().add(ResetPasswordValidation());

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
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocListener<PasswordBloc, PasswordState>(
            listener: (context, state) {
              debugPrint(
                  'BlocListener: isSuccess: ${state.isSuccess}, errorMessage: ${state.errorMessage}, isPasswordValid: ${state.isPasswordValid}, isConfirmPasswordValid: ${state.isConfirmPasswordValid}');

              // Update controllers when state changes
              if (_passwordController.text != state.password) {
                _passwordController.text = state.password;
              }

              if (_confirmPasswordController.text != state.confirmPassword) {
                _confirmPasswordController.text = state.confirmPassword;
              }

              if (state.isSuccess) {
                debugPrint(
                    'Navigation triggered: going to CreateProfileScreen');
                // Show success message
                AppToast.show(
                  message: Lang.of(context).passwordsetsuccessfully,
                  type: ToastificationType.success,
                );
                // Navigate to create profile screen with a small delay to allow the snackbar to be
                _navigateToProfileScreen(context);
              }
              if (state.errorMessage != null) {
                debugPrint('Error message shown: ${state.errorMessage}');
                AppToast.show(
                  message: state.errorMessage!,
                  type: ToastificationType.error,
                );
              }
            },
            child: BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
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
                                    previous.password != current.password ||
                                    previous.isPasswordValid !=
                                        current.isPasswordValid,
                                builder: (context, state) {
                                  return CustomPasswordField(
                                    hintText: Lang.of(context).hintPassword,
                                    isValid: state.isPasswordValid,
                                    controller: _passwordController,
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
                                    isValid: state.isConfirmPasswordValid,
                                    isConfirmMatch:
                                        state.isConfirmPasswordValid,
                                    controller: _confirmPasswordController,
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
                        padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
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
                                      debugPrint(
                                          'Register button pressed, submitting password');
                                      context
                                          .read<PasswordBloc>()
                                          .add(PasswordSubmitted());
                                      // Hide keyboard when button is pressed
                                      FocusScope.of(context).unfocus();
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
