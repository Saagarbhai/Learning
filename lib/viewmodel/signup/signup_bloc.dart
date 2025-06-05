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

  // Use the key from KeysManager instead of creating a new one
  final formKey = KeysManager.signUpFormKey;

  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpFormChanged>(_onSignUpFormChanged);
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
    on<SignUpWithGmail>(_onSignUpWithGmail);
    on<SignUpWithFacebook>(_onSignUpWithFacebook);
    on<SignUpWithApple>(_onSignUpWithApple);
    on<NavigateToSignIn>(_onNavigateToSignIn);
    on<UpdateSelectedGender>(_onUpdateSelectedGender);
    on<InitializeSignUp>(_onInitializeSignUp);
    on<DisposeSignUp>(_onDisposeSignUp);

    // Initialize controllers with listeners
    nameController.addListener(_nameControllerListener);
    emailController.addListener(_emailControllerListener);
    phoneController.addListener(_phoneControllerListener);
  }

  void _nameControllerListener() {
    add(SignUpFormChanged(name: nameController.text));
  }

  void _emailControllerListener() {
    add(SignUpFormChanged(email: emailController.text));
  }

  void _phoneControllerListener() {
    add(SignUpFormChanged(phoneNumber: phoneController.text));
  }

  void _onInitializeSignUp(InitializeSignUp event, Emitter<SignUpState> emit) {
    // Reset controllers if needed
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    selectedGender = null;

    // Initialize form validation state with controllers
    emit(SignUpFormValidationState(
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
      isFormValid: false,
    ));
  }

  void _onDisposeSignUp(DisposeSignUp event, Emitter<SignUpState> emit) {
    // Don't dispose controllers here, they will be disposed in close()
    emit(SignUpInitial(
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
    ));
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
        nameController: nameController,
        emailController: emailController,
        phoneController: phoneController,
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
        nameController: nameController,
        emailController: emailController,
        phoneController: phoneController,
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
    // Emit the navigation state
    emit(NavigateToSignInState());
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
    // Remove listeners
    nameController.removeListener(_nameControllerListener);
    emailController.removeListener(_emailControllerListener);
    phoneController.removeListener(_phoneControllerListener);

    // Dispose controllers when bloc is closed
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
