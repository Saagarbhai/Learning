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
          state.nameController.clear();
          state.emailController.clear();
          state.phoneController.clear();
          context.read<SignUpBloc>().add(UpdateSelectedGender(gender: ''));
          // Navigate to the OTP verification screen after successful signup
          Navigator.of(context).pushNamed(AppConstants.otpVerificationRoute);
        }

        if (state.navigateToSignIn) {
          context.read<SignUpBloc>().add(DisposeSignUp());
          state.nameController.clear();
          state.emailController.clear();
          state.phoneController.clear();
          context.read<SignUpBloc>().add(UpdateSelectedGender(gender: ''));
          Navigator.of(context).pushNamed(AppConstants.signInRoute);
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: const SafeArea(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: Form(
          key: bloc.formKey,
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
                controller: bloc.nameController,
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
                controller: bloc.emailController,
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
                controller: bloc.phoneController,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  context.read<SignUpBloc>().add(
                        SignUpFormChanged(phoneNumber: value),
                      );
                },
                validator: (value) {
                  return null; // Either email or phone is required, handled in the bloc
                },
              ),
              SizedBox(height: 16.h),

              // Gender dropdown
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  final signUpBloc = context.read<SignUpBloc>();
                  return CustomDropdownField(
                    hintText: Lang.of(context).hintGender,
                    items: signUpBloc.genders,
                    value: signUpBloc.selectedGender,
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
                  final signUpBloc = context.read<SignUpBloc>();
                  bool isLoading = state.isLoading;
                  bool isFormValid = state.isFormValid;

                  return CustomButton(
                    text: Lang.of(context).signupButton,
                    width: double.infinity,
                    isLoading: isLoading,
                    onPressed: isLoading || !isFormValid
                        ? null
                        : () {
                            bloc.formKey.currentState!.reset();
                            if (signUpBloc.formKey.currentState!.validate()) {
                              context.read<SignUpBloc>().add(
                                    SignUpWithEmailAndPassword(
                                      name: signUpBloc.nameController.text,
                                      email: signUpBloc.emailController.text,
                                      phoneNumber:
                                          signUpBloc.phoneController.text,
                                      gender: signUpBloc.selectedGender!,
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
                  context.read<SignUpBloc>().add(SignUpWithGmail());
                },
                isDisabled: true,
              ),

              SocialSignButton.facebook(
                text: Lang.of(context).signupwithFaceBook,
                onPressed: () {
                  context.read<SignUpBloc>().add(SignUpWithFacebook());
                },
                isDisabled: true,
              ),

              SocialSignButton.apple(
                text: Lang.of(context).signupwithApple,
                onPressed: () {
                  context.read<SignUpBloc>().add(SignUpWithApple());
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
                        context.read<SignUpBloc>().add(NavigateToSignIn());
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
