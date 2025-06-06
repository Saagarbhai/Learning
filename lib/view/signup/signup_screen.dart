import 'package:learning/core/utils/app_export.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppToast.show(
            message: state.errorMessage!,
            type: ToastificationType.error,
          );
        }

        if (state.isSignUpSuccess) {
          // Navigate to the OTP verification screen after successful signup
          Navigator.of(context).pushNamed(AppConstants.otpVerificationRoute);
          state.nameController.clear();
          state.emailController.clear();
          state.phoneController.clear();
          // context.read<SignUpBloc>().add(UpdateSelectedGender(gender: null));
        }

        if (state.navigateToSignIn) {
          Navigator.of(context).pushNamed(AppConstants.signInRoute);
          state.nameController.clear();
          state.emailController.clear();
          state.phoneController.clear();
          // context.read<SignUpBloc>().add(UpdateSelectedGender(gender: null));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: CustomBackButton(
            onPressed: () {
              // Dispose the bloc before popping
              context.read<SignUpBloc>().add(DisposeSignUp());
              Navigator.of(context).pop();
            },
          ),
          actions: [
            LanguageButton(),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = context.read<SignUpBloc>().state;
    final signUpBloc = context.read<SignUpBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Lang.of(context).signupInfo,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(height: 24.h),

              // Name field
              CustomTextField(
                hintText: Lang.of(context).name,
                controller: state.nameController,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  context.read<SignUpBloc>().add(
                        SignUpFormChanged(name: value),
                      );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Email field
              CustomTextField(
                hintText: Lang.of(context).hintEmail,
                controller: state.emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  context.read<SignUpBloc>().add(
                        SignUpFormChanged(email: value),
                      );
                },
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Phone field
              CustomPhoneField(
                hintText: Lang.of(context).hintPhone,
                controller: state.phoneController,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  context.read<SignUpBloc>().add(
                        SignUpFormChanged(phoneNumber: value),
                      );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null; // Either email or phone is required, handled in the bloc
                },
              ),
              SizedBox(height: 16.h),

              // Gender dropdown
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return CustomDropdownField(
                    hintText: Lang.of(context).hintGender,
                    items: state.genders,
                    value: state.selectedGender,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<SignUpBloc>().add(
                              UpdateSelectedGender(gender: value),
                            );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(height: 24.h),

              // Terms and conditions
              Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00A86B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Color(0xFF00A86B),
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFF666666),
                          fontFamily: 'Poppins',
                        ),
                        children: [
                          TextSpan(text: Lang.of(context).signTextSpan1),
                          TextSpan(
                            text: Lang.of(context).signTextSpan2,
                            style: TextStyle(
                              color: Color(0xFF00A86B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: Lang.of(context).signTextSpan3),
                          TextSpan(
                            text: Lang.of(context).signTextSpan4,
                            style: TextStyle(
                              color: Color(0xFF00A86B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Sign Up button
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  bool isLoading = state.isLoading;
                  bool isFormValid = state.isFormValid;

                  return CustomButton(
                    text: Lang.of(context).signupButton,
                    width: double.infinity,
                    isLoading: isLoading,
                    onPressed: isLoading || !isFormValid
                        ? null
                        : () {
                            // Hide keyboard when button is pressed
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              signUpBloc.add(
                                SignUpWithEmailAndPassword(
                                  name: state.nameController.text,
                                  email: state.emailController.text,
                                  phoneNumber: state.phoneController.text,
                                  gender: state.selectedGender!,
                                ),
                              );
                            }
                          },
                  );
                },
              ),

              // OR divider
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: Color(0xFFE0E0E0), thickness: 1.w),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        Lang.of(context).or,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Color(0xFFE0E0E0), thickness: 1.w),
                    ),
                  ],
                ),
              ),

              // Social sign-up buttons
              SocialSignButton.gmail(
                text: Lang.of(context).signupwithGmail,
                onPressed: () {
                  signUpBloc.add(SignUpWithGmail());
                },
                isDisabled: true,
              ),

              SocialSignButton.facebook(
                text: Lang.of(context).signupwithFaceBook,
                onPressed: () {
                  signUpBloc.add(SignUpWithFacebook());
                },
                isDisabled: true,
              ),

              SocialSignButton.apple(
                text: Lang.of(context).signupwithApple,
                onPressed: () {
                  signUpBloc.add(SignUpWithApple());
                },
                isDisabled: true,
              ),

              // Already have an account
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Lang.of(context).alreadyAccount,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF666666),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        signUpBloc.add(NavigateToSignIn());
                      },
                      child: Text(
                        Lang.of(context).signIn,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00A86B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
