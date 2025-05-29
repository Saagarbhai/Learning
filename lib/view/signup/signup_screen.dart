import 'package:learning/core/utils/app_export.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          // Navigate to the OTP verification screen after successful signup
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Lang.of(context).signupSuccessful),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );

          // Navigate to OTP verification screen
          Navigator.of(context).pushNamed(AppConstants.otpVerificationRoute);
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Lang.of(context).signupFail + ': ${state.error}'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const CustomBackButton(),
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
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: bloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Lang.of(context).signupInfo,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 24),

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
              const SizedBox(height: 16),

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
              const SizedBox(height: 16),

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
              const SizedBox(height: 16),

              // Gender dropdown
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  final signUpBloc = context.read<SignUpBloc>();

                  if (state is SignUpFormValidationState) {
                    signUpBloc.selectedGender = state.gender;
                  }

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
              const SizedBox(height: 24),

              // Terms and conditions
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00A86B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color(0xFF00A86B),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          fontFamily: 'Poppins',
                        ),
                        children: [
                          TextSpan(text: Lang.of(context).signTextSpan1),
                          TextSpan(
                            text: Lang.of(context).signTextSpan2,
                            style: const TextStyle(
                              color: Color(0xFF00A86B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: Lang.of(context).signTextSpan3),
                          TextSpan(
                            text: Lang.of(context).signTextSpan4,
                            style: const TextStyle(
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
              const SizedBox(height: 24),

              // Sign Up button
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  final signUpBloc = context.read<SignUpBloc>();
                  bool isLoading = state is SignUpLoading;
                  bool isFormValid = state is SignUpFormValidationState
                      ? (state).isFormValid
                      : false;

                  return CustomButton(
                    text: Lang.of(context).signupButton,
                    width: double.infinity,
                    isLoading: isLoading,
                    onPressed: isLoading || !isFormValid
                        ? null
                        : () {
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
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: Color(0xFFE0E0E0), thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        Lang.of(context).or,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Color(0xFFE0E0E0), thickness: 1),
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
              ),

              SocialSignButton.facebook(
                text: Lang.of(context).signupwithFaceBook,
                onPressed: () {
                  context.read<SignUpBloc>().add(SignUpWithFacebook());
                },
              ),

              SocialSignButton.apple(
                text: Lang.of(context).signupwithApple,
                onPressed: () {
                  context.read<SignUpBloc>().add(SignUpWithApple());
                },
              ),

              // Already have an account
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Lang.of(context).alreadyAccount,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<SignUpBloc>().add(NavigateToSignIn());
                      },
                      child: Text(
                        Lang.of(context).signIn,
                        style: const TextStyle(
                          fontSize: 14,
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
