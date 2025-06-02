import '../../core/utils/app_export.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the bloc when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignInBloc>().add(InitializeSignIn());
    });

    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }

        if (state.isSignInSuccess) {
          // Navigate to home screen or dashboard
          Navigator.of(context).pushReplacementNamed(AppConstants.homeRoute);
        }

        if (state.navigateToSignUp) {
          Navigator.of(context).pushNamed(AppConstants.signUpRoute);
        }

        if (state.navigateToForgotPassword) {
          // Navigate to forgot password screen
          // This would be implemented when you create the forgot password screen
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: CustomBackButton(
            onPressed: () {
              // Dispose the bloc before popping
              context.read<SignInBloc>().add(DisposeSignIn());
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  // Title
                  Text(
                    'Sign in with your email or\nphone number',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Email/Phone Field
                  CustomTextField(
                    hintText: 'Email or Phone Number',
                    controller: state.emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      context.read<SignInBloc>().add(UpdateEmail(value));
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email or phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Password Field
                  CustomSignInPasswordField(
                    hintText: 'Enter Your Password',
                    controller: state.passwordController,
                    onChanged: (value) {
                      context.read<SignInBloc>().add(UpdatePassword(value));
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.read<SignInBloc>().add(ForgotPasswordPressed());
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 36),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xFFFF3B30),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Sign In Button
                  CustomButton(
                    text: 'Sign In',
                    onPressed: state.isLoading
                        ? null
                        : () {
                            if (state.formKey.currentState?.validate() ??
                                false) {
                              context.read<SignInBloc>().add(
                                    SignInWithEmailPasswordPressed(
                                      email: state.emailController.text,
                                      password: state.passwordController.text,
                                    ),
                                  );
                            }
                          },
                    isLoading: state.isLoading,
                    width: double.infinity,
                  ),

                  // OR Divider
                  SizedBox(height: 24.h),
                  _buildOrDivider(),
                  SizedBox(height: 24.h),

                  // Social Sign In Buttons
                  SocialSignButton.gmail(
                    text: 'Sign in with Gmail',
                    onPressed: () {
                      context.read<SignInBloc>().add(SignInWithGmailPressed());
                    },
                  ),
                  SocialSignButton.facebook(
                    text: 'Sign in with Facebook',
                    onPressed: () {
                      context
                          .read<SignInBloc>()
                          .add(SignInWithFacebookPressed());
                    },
                  ),
                  SocialSignButton.apple(
                    text: 'Sign in with Apple',
                    onPressed: () {
                      context.read<SignInBloc>().add(SignInWithApplePressed());
                    },
                  ),

                  // Don't have an account
                  SizedBox(height: 24.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<SignInBloc>()
                                .add(NavigateToSignUpPressed());
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF00A86B),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFE0E0E0),
            thickness: 1.w,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Text(
            'or',
            style: TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 14.sp,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFE0E0E0),
            thickness: 1.w,
          ),
        ),
      ],
    );
  }
}
