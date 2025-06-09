import 'package:learning/core/utils/app_export.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
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
    state.nameController.addListener(_nameControllerListener);
    state.emailController.addListener(_emailControllerListener);
    state.phoneController.addListener(_phoneControllerListener);
  }

  void _nameControllerListener() {
    add(SignUpFormChanged(name: state.nameController.text));
  }

  void _emailControllerListener() {
    add(SignUpFormChanged(email: state.emailController.text));
  }

  void _phoneControllerListener() {
    add(SignUpFormChanged(phoneNumber: state.phoneController.text));
  }

  void _onInitializeSignUp(InitializeSignUp event, Emitter<SignUpState> emit) {
    // Reset controllers
    state.nameController.clear();
    state.emailController.clear();
    state.phoneController.clear();

    // Initialize state with fresh controllers and reset all validation states
    emit(SignUpState(
      nameController: state.nameController,
      emailController: state.emailController,
      phoneController: state.phoneController,
      name: '',
      email: '',
      phoneNumber: '',
      gender: null,
      selectedGender: null,
      isSignUpSuccess: false,
      navigateToSignIn: false,
      errorMessage: null,
      isLoading: false,
    ));
  }

  void _onDisposeSignUp(DisposeSignUp event, Emitter<SignUpState> emit) {
    // Don't dispose controllers here, they will be disposed in close()
    emit(SignUpState(
      nameController: state.nameController,
      emailController: state.emailController,
      phoneController: state.phoneController,
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
    emit(state.copyWith(
      gender: event.gender,
      selectedGender: event.gender,
    ));
  }

  void _onSignUpWithEmailAndPassword(
    SignUpWithEmailAndPassword event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
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
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      // Emit success state
      emit(state.copyWith(isLoading: false, isSignUpSuccess: true));
    } catch (e) {
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
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      // Emit success state
      emit(state.copyWith(isLoading: false, isSignUpSuccess: true));
    } catch (e) {
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
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      // Emit success state
      emit(state.copyWith(isLoading: false, isSignUpSuccess: true));
    } catch (e) {
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
    emit(state.copyWith(navigateToSignIn: true));
  }

  @override
  Future<void> close() {
    // Remove listeners
    state.nameController.removeListener(_nameControllerListener);
    state.emailController.removeListener(_emailControllerListener);
    state.phoneController.removeListener(_phoneControllerListener);

    // Dispose controllers
    state.nameController.dispose();
    state.emailController.dispose();
    state.phoneController.dispose();

    return super.close();
  }
}
