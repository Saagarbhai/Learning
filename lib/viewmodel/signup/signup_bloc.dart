import 'package:learning/core/utils/app_export.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // Controllers moved from the widget
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Gender list moved from the widget
  final List<String> genders = [
    'Male',
    'Female',
    'Other',
  ];
  String? selectedGender;

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpFormChanged>(_onSignUpFormChanged);
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
    on<SignUpWithGmail>(_onSignUpWithGmail);
    on<SignUpWithFacebook>(_onSignUpWithFacebook);
    on<SignUpWithApple>(_onSignUpWithApple);
    on<NavigateToSignIn>(_onNavigateToSignIn);
    on<UpdateSelectedGender>(_onUpdateSelectedGender);
  }

  void _onSignUpFormChanged(
    SignUpFormChanged event,
    Emitter<SignUpState> emit,
  ) {
    if (state is SignUpFormValidationState) {
      final currentState = state as SignUpFormValidationState;
      final updatedState = currentState.copyWith(
        name: event.name ?? currentState.name,
        email: event.email ?? currentState.email,
        phoneNumber: event.phoneNumber ?? currentState.phoneNumber,
        gender: event.gender ?? currentState.gender,
      );

      final bool isFormValid = _validateForm(
        name: updatedState.name,
        email: updatedState.email,
        phoneNumber: updatedState.phoneNumber,
        gender: updatedState.gender,
      );

      emit(updatedState.copyWith(isFormValid: isFormValid));
    } else {
      final bool isFormValid = _validateForm(
        name: event.name,
        email: event.email,
        phoneNumber: event.phoneNumber,
        gender: event.gender,
      );

      emit(SignUpFormValidationState(
        name: event.name,
        email: event.email,
        phoneNumber: event.phoneNumber,
        gender: event.gender,
        isFormValid: isFormValid,
      ));
    }
  }

  void _onUpdateSelectedGender(
    UpdateSelectedGender event,
    Emitter<SignUpState> emit,
  ) {
    selectedGender = event.gender;
    add(SignUpFormChanged(gender: event.gender));
  }

  void _onSignUpWithEmailAndPassword(
    SignUpWithEmailAndPassword event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      // Here you would typically make an API call to register the user
      // For now, we'll just simulate a successful registration
      await Future.delayed(const Duration(seconds: 2));

      // Emit success state and pop back to welcome screen
      emit(SignUpSuccess());

      // The navigation will be handled in the UI with BlocListener
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }

  void _onSignUpWithGmail(
    SignUpWithGmail event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      // Here you would implement Gmail sign-up logic
      await Future.delayed(const Duration(seconds: 2));
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }

  void _onSignUpWithFacebook(
    SignUpWithFacebook event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      // Here you would implement Facebook sign-up logic
      await Future.delayed(const Duration(seconds: 2));
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }

  void _onSignUpWithApple(
    SignUpWithApple event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      // Here you would implement Apple sign-up logic
      await Future.delayed(const Duration(seconds: 2));
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }

  void _onNavigateToSignIn(
    NavigateToSignIn event,
    Emitter<SignUpState> emit,
  ) {
    // This state can be used to navigate to sign in screen
    // The actual navigation will be handled in the UI
  }

  bool _validateForm({
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
  }) {
    // Simple validation
    final bool isNameValid = name != null && name.isNotEmpty;
    final bool isEmailValid = email != null &&
        RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$').hasMatch(email);
    final bool isPhoneValid = phoneNumber != null && phoneNumber.isNotEmpty;
    final bool isGenderValid = gender != null && gender.isNotEmpty;

    return isNameValid && (isEmailValid || isPhoneValid) && isGenderValid;
  }

  @override
  Future<void> close() {
    // Dispose controllers when bloc is closed
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
