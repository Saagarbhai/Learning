import '../../core/utils/app_export.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
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
    // No need to do anything as controllers are already initialized in constructor
  }

  void _onDisposeSignIn(DisposeSignIn event, Emitter<SignInState> emit) {
    state.emailController.removeListener(_emailControllerListener);
    state.passwordController.removeListener(_passwordControllerListener);
    state.emailController.dispose();
    state.passwordController.dispose();
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
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, just check if email contains @ and password is not empty
      if (event.email.contains('@') && event.password.isNotEmpty) {
        emit(state.copyWith(isLoading: false, isSignInSuccess: true));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid email or password',
        ));
      }
    } catch (e) {
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
      await Future.delayed(const Duration(seconds: 2));
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
      await Future.delayed(const Duration(seconds: 2));
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
    emit(SignInState());
  }

  @override
  Future<void> close() {
    state.emailController.removeListener(_emailControllerListener);
    state.passwordController.removeListener(_passwordControllerListener);
    state.emailController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
