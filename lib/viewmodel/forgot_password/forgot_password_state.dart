import 'package:learning/core/utils/app_export.dart';

class ForgotPasswordState extends Equatable {
  final String verificationInput;
  final bool isLoading;
  final String? errorMessage;
  final bool isOtpSent;
  final bool isInputValid;
  final TextEditingController inputController;

  ForgotPasswordState({
    this.verificationInput = '',
    this.isLoading = false,
    this.errorMessage,
    this.isOtpSent = false,
    this.isInputValid = false,
    TextEditingController? inputController,
  }) : inputController = inputController ?? TextEditingController();

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
    );
  }

  @override
  List<Object?> get props => [
        verificationInput,
        isLoading,
        errorMessage,
        isOtpSent,
        isInputValid,
      ];
}
