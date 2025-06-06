import 'package:learning/core/utils/app_export.dart';

class ForgotPasswordState extends Equatable {
  final String verificationInput;
  final bool isLoading;
  final String? errorMessage;
  final bool isOtpSent;
  final bool isInputValid;
  final TextEditingController inputController;
  final GlobalKey<FormState> formKey;

  ForgotPasswordState({
    this.verificationInput = '',
    this.isLoading = false,
    this.errorMessage,
    this.isOtpSent = false,
    this.isInputValid = false,
    TextEditingController? inputController,
    GlobalKey<FormState>? formKey,
  })  : this.inputController = inputController ?? TextEditingController(),
        this.formKey = formKey ?? KeysManager.createForgotPasswordFormKey();

  ForgotPasswordState copyWith({
    String? verificationInput,
    bool? isLoading,
    String? errorMessage,
    bool? isOtpSent,
    bool? isInputValid,
  }) {
    return ForgotPasswordState(
      verificationInput: verificationInput ?? this.verificationInput,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      isInputValid: isInputValid ?? this.isInputValid,
      inputController: inputController,
      formKey: formKey,
    );
  }

  @override
  List<Object?> get props => [
        verificationInput,
        isLoading,
        errorMessage,
        isOtpSent,
        isInputValid,
        formKey,
      ];
}
