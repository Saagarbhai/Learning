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

  SignUpBloc() : super(SignUpState.initial()) {
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

    // Initialize state with fresh controllers
    emit(SignUpState(
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
    ));
  }

  void _onDisposeSignUp(DisposeSignUp event, Emitter<SignUpState> emit) {
    // Don't dispose controllers here, they will be disposed in close()
    emit(SignUpState(
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
    ));
  }

  void _onSignUpFormChanged(
    SignUpFormChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(
      name: event.name ?? state.name,
      email: event.email ?? state.email,
      phoneNumber: event.phoneNumber ?? state.phoneNumber,
      gender: event.gender ?? state.gender,
    ));
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
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Here you would typically make an API call to register the user
      // For now, we'll just simulate a successful registration
      await Future.delayed(const Duration(seconds: 2));

      // Show success toast
      AppToast.show(
        message: "Registration successful",
        type: ToastificationType.success,
      );

      // Emit success state
      emit(state.copyWith(isLoading: false, isSignUpSuccess: true));

      // The navigation will be handled in the UI with BlocListener
    } catch (e) {
      // Show error toast
      AppToast.show(
        message: e.toString(),
        type: ToastificationType.error,
      );

      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSignUpWithGmail(
    SignUpWithGmail event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Here you would implement Gmail sign-up logic
      await Future.delayed(const Duration(seconds: 2));

      // Show success toast
      AppToast.show(
        message: "Gmail registration successful",
        type: ToastificationType.success,
      );

      emit(state.copyWith(isLoading: false, isSignUpSuccess: true));
    } catch (e) {
      // Show error toast
      AppToast.show(
        message: e.toString(),
        type: ToastificationType.error,
      );

      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSignUpWithFacebook(
    SignUpWithFacebook event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Here you would implement Facebook sign-up logic
      await Future.delayed(const Duration(seconds: 2));

      // Show success toast
      AppToast.show(
        message: "Facebook registration successful",
        type: ToastificationType.success,
      );

      emit(state.copyWith(isLoading: false, isSignUpSuccess: true));
    } catch (e) {
      // Show error toast
      AppToast.show(
        message: e.toString(),
        type: ToastificationType.error,
      );

      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSignUpWithApple(
    SignUpWithApple event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Here you would implement Apple sign-up logic
      await Future.delayed(const Duration(seconds: 2));

      // Show success toast
      AppToast.show(
        message: "Apple registration successful",
        type: ToastificationType.success,
      );

      emit(state.copyWith(isLoading: false, isSignUpSuccess: true));
    } catch (e) {
      // Show error toast
      AppToast.show(
        message: e.toString(),
        type: ToastificationType.error,
      );

      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onNavigateToSignIn(
    NavigateToSignIn event,
    Emitter<SignUpState> emit,
  ) {
    // Emit the navigation state
    emit(state.copyWith(navigateToSignIn: true));
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
