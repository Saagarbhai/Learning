import '../../core/utils/app_export.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState.initial()) {
    on<UpdateEmail>(_onUpdateEmail);
    on<UpdatePassword>(_onUpdatePassword);
    on<ToggleSignInPasswordVisibility>(_onTogglePasswordVisibility);
    on<SignInWithEmailPasswordPressed>(_onSignInWithEmailPasswordPressed);
    on<SignInWithGmailPressed>(_onSignInWithGmailPressed);
    on<SignInWithFacebookPressed>(_onSignInWithFacebookPressed);
    on<SignInWithApplePressed>(_onSignInWithApplePressed);
    on<ForgotPasswordPressed>(_onForgotPasswordPressed);
    on<NavigateToSignUpPressed>(_onNavigateToSignUpPressed);
    on<ResetSignInState>(_onResetSignInState);
    on<InitializeSignIn>(_onInitializeSignIn);
    on<DisposeSignIn>(_onDisposeSignIn);

    // Initialize controllers
    state.emailController.addListener(_emailControllerListener);
    state.passwordController.addListener(_passwordControllerListener);
  }

  void _emailControllerListener() {
    add(UpdateEmail(state.emailController.text));
  }

  void _passwordControllerListener() {
    add(UpdatePassword(state.passwordController.text));
  }

  void _onInitializeSignIn(InitializeSignIn event, Emitter<SignInState> emit) {
    emit(SignInState(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    ));
  }

  void _onDisposeSignIn(DisposeSignIn event, Emitter<SignInState> emit) {
    // Don't dispose controllers here, they will be disposed in close()
    emit(SignInState(
      emailController: state.emailController,
      passwordController: state.passwordController,
    ));
  }

  void _onUpdateEmail(UpdateEmail event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onUpdatePassword(UpdatePassword event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onTogglePasswordVisibility(
      ToggleSignInPasswordVisibility event, Emitter<SignInState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onSignInWithEmailPasswordPressed(
      SignInWithEmailPasswordPressed event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final loginModel = await state.authRepository.loginWithEmailPassword(
        email: event.email,
        password: event.password,
      );

      if (loginModel.status == true && loginModel.data != null) {
        // Save user data in shared preferences for persistence
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user_token', loginModel.token ?? '');
        prefs.setString('user_name', loginModel.data!.fullName);
        prefs.setString('user_email', loginModel.data!.email);
        prefs.setString('user_image', loginModel.data!.image ?? '');

        // Show success toast
        AppToast.show(
          message: loginModel.message,
          type: ToastificationType.success,
        );

        emit(state.copyWith(
          isLoading: false,
          isSignInSuccess: true,
          userData: loginModel.data,
          token: loginModel.token,
        ));
      } else {
        // Show error toast
        AppToast.show(
          message: loginModel.message,
          type: ToastificationType.error,
        );

        emit(state.copyWith(
          isLoading: false,
          errorMessage: loginModel.message,
        ));
      }
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

  Future<void> _onSignInWithGmailPressed(
      SignInWithGmailPressed event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Simulate API call with delay
      // await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isLoading: false, isSignInSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSignInWithFacebookPressed(
      SignInWithFacebookPressed event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Simulate API call with delay
      // await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isLoading: false, isSignInSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSignInWithApplePressed(
      SignInWithApplePressed event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isLoading: false, isSignInSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onForgotPasswordPressed(
      ForgotPasswordPressed event, Emitter<SignInState> emit) {
    emit(state.copyWith(navigateToForgotPassword: true));
  }

  void _onNavigateToSignUpPressed(
      NavigateToSignUpPressed event, Emitter<SignInState> emit) {
    emit(state.copyWith(navigateToSignUp: true));
  }

  void _onResetSignInState(ResetSignInState event, Emitter<SignInState> emit) {
    emit(SignInState.initial());
  }

  @override
  Future<void> close() {
    // Remove listeners
    state.emailController.removeListener(_emailControllerListener);
    state.passwordController.removeListener(_passwordControllerListener);

    // Dispose controllers
    state.emailController.dispose();
    state.passwordController.dispose();

    return super.close();
  }
}
