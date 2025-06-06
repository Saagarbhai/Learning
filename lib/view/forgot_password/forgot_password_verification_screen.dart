import 'package:learning/core/utils/app_export.dart';

class ForgotPasswordVerificationScreen extends StatelessWidget {
  ForgotPasswordVerificationScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Initialize the bloc when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ForgotPasswordBloc>().add(InitializeForgotPassword());
    });

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppToast.show(
            message: state.errorMessage!,
            type: ToastificationType.error,
          );
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
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // Title
                  Text(
                    Lang.of(context).verificationEmailorPhone,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Email or phone input field
                  CustomTextField(
                    hintText: Lang.of(context).hintEmailofPhone,
                    controller: state.inputController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      context.read<ForgotPasswordBloc>().add(
                            VerificationInputChanged(input: value),
                          );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email or phone number';
                      }
                      return null;
                    },
                  ),

                  Expanded(child: Container()),

                  // Send OTP Button
                  CustomButton(
                    text: Lang.of(context).sendOTP,
                    onPressed: state.isInputValid
                        ? () {
                            Navigator.of(context)
                                .pushNamed(AppConstants.otpVerificationRoute);
                          }
                        : null,
                    width: double.infinity,
                    height: 58.h,
                    isLoading: state.isLoading,
                    showShadow: true,
                    fontSize: 18.sp,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    fontWeight: FontWeight.w600,
                    margin: EdgeInsets.only(bottom: 16.h),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
