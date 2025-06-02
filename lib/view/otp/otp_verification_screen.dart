import 'package:learning/core/utils/app_export.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccess) {
          // Navigate to the next screen after successful verification
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Lang.of(context).verificationSuccessful),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );

          // Navigate to password screen after successful verification
          Navigator.of(context)
              .pushReplacementNamed(AppConstants.passwordRoute);
        } else if (state is OtpVerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed: ${state.error}'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else if (state is OtpResendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Lang.of(context).otpResent),
              backgroundColor: const Color(0xFF00A86B),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      child: Scaffold(
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
        body: const SafeArea(
          child: OtpVerificationForm(),
        ),
      ),
    );
  }
}

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({Key? key}) : super(key: key);

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OtpVerificationBloc>();

    return BlocListener<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccess) {
          // Clear the Pinput field when verification is successful
          _pinController.clear();
        } else if (state is OtpResendSuccess) {
          // Clear the Pinput field when OTP is resent
          _pinController.clear();
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: bloc.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          Lang.of(context).phoneVerification,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1A1A1A),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Subtitle
                        Text(
                          Lang.of(context).enterOtpCode,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 40.h),

                        // OTP fields with CustomPinBox
                        CustomPinBox(
                          controller: _pinController,
                          onCompleted: (pin) {
                            context.read<OtpVerificationBloc>().add(
                                  VerifyOtp(otp: pin),
                                );
                          },
                          onChanged: (value) {
                            context.read<OtpVerificationBloc>().add(
                                  OtpChanged(otp: value),
                                );
                          },
                        ),
                        SizedBox(height: 20.h),

                        // Resend code text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Lang.of(context).didntReceiveCode,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<OtpVerificationBloc>()
                                    .add(ResendOtp());
                              },
                              child: Text(
                                Lang.of(context).resendAgain,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF00A86B),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Verify button at the bottom
                BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
                  builder: (context, state) {
                    final isLoading = state is OtpVerificationLoading;

                    return CustomButton(
                      text: Lang.of(context).verify,
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<OtpVerificationBloc>().add(
                                    VerifyOtp(otp: _pinController.text),
                                  );
                            },
                      width: double.infinity,
                      height: 58.h,
                      isLoading: isLoading,
                      showShadow: true,
                      fontSize: 18.sp,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      fontWeight: FontWeight.w600,
                      margin: EdgeInsets.only(bottom: 16.h),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
