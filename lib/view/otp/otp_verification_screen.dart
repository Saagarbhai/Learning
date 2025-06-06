import 'package:learning/core/utils/app_export.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {
        if (state.status == OtpVerificationStatus.success) {
          // Navigate to the next screen after successful verification
          AppToast.show(
            message: Lang.of(context).verificationSuccessful,
            type: ToastificationType.success,
          );

          // Navigate to password screen after successful verification
          Navigator.of(context)
              .pushReplacementNamed(AppConstants.passwordRoute);
        } else if (state.status == OtpVerificationStatus.failure &&
            state.errorMessage != null) {
          AppToast.show(
            message: 'Verification failed: ${state.errorMessage}',
            type: ToastificationType.error,
          );
        } else if (state.status == OtpVerificationStatus.resendSuccess) {
          AppToast.show(
            message: Lang.of(context).otpResent,
            type: ToastificationType.success,
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
        body: SafeArea(
          child: OtpVerificationForm(),
        ),
      ),
    );
  }
}

class OtpVerificationForm extends StatelessWidget {
  OtpVerificationForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final otpVerificationBloc = context.read<OtpVerificationBloc>();
    return BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
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
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 12.h),

                          // Subtitle
                          Text(
                            Lang.of(context).enterOtpCode,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF666666),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 40.h),

                          // OTP fields with CustomPinBox
                          CustomPinBox(
                            controller: state.pinController,
                            onCompleted: (pin) {
                              otpVerificationBloc.add(
                                VerifyOtp(otp: pin),
                              );
                            },
                            onChanged: (value) {
                              otpVerificationBloc.add(
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
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF666666),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  otpVerificationBloc.add(ResendOtp());
                                },
                                child: Text(
                                  Lang.of(context).resendAgain,
                                  style: TextStyle(
                                    fontSize: 14.sp,
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
                      final isLoading =
                          state.status == OtpVerificationStatus.loading;

                      return CustomButton(
                        text: Lang.of(context).verify,
                        onPressed: isLoading
                            ? null
                            : () {
                                otpVerificationBloc.add(
                                  VerifyOtp(
                                    otp: state.pinController.text,
                                  ),
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
        );
      },
    );
  }
}
