import '../../core/utils/app_export.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ApiService _apiService = ApiService();

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
    // Only remove listeners and dispose if controllers are not already disposed
    if (!state.shouldDisposeControllers) {
      state.emailController.removeListener(_emailControllerListener);
      state.passwordController.removeListener(_passwordControllerListener);

      // Only dispose if they haven't been disposed already
      if (state.emailController.hasListeners) {
        state.emailController.dispose();
      }
      if (state.passwordController.hasListeners) {
        state.passwordController.dispose();
      }
    }
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
      // For other users, try the API
      final user = await _apiService.login(event.email, event.password);

      // If login is successful, the login method will return a user
      if (user != null) {
        // Mark controllers as ready to dispose
        emit(state.copyWith(
            isLoading: false,
            isSignInSuccess: true,
            shouldDisposeControllers: true));
      } else {
        // This shouldn't happen as the login method throws an exception on failure
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid email or password',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Login failed: Invalid email or password',
      ));
    }
  }

  Future<void> _onSignInWithGmailPressed(
      SignInWithGmailPressed event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));
      // Mark controllers as ready to dispose
      emit(state.copyWith(
          isLoading: false,
          isSignInSuccess: true,
          shouldDisposeControllers: true));
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
      // Mark controllers as ready to dispose
      emit(state.copyWith(
          isLoading: false,
          isSignInSuccess: true,
          shouldDisposeControllers: true));
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
      // Mark controllers as ready to dispose
      emit(state.copyWith(
          isLoading: false,
          isSignInSuccess: true,
          shouldDisposeControllers: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onForgotPasswordPressed(
      ForgotPasswordPressed event, Emitter<SignInState> emit) {
    // Mark controllers as ready to dispose
    emit(state.copyWith(
        navigateToForgotPassword: true, shouldDisposeControllers: true));
  }

  void _onNavigateToSignUpPressed(
      NavigateToSignUpPressed event, Emitter<SignInState> emit) {
    // Mark controllers as ready to dispose
    emit(
        state.copyWith(navigateToSignUp: true, shouldDisposeControllers: true));
  }

  void _onResetSignInState(ResetSignInState event, Emitter<SignInState> emit) {
    emit(SignInState());
  }

  @override
  Future<void> close() {
    // Only remove listeners and dispose if not already disposed
    if (!state.shouldDisposeControllers) {
      try {
        // Check if controllers are still valid before disposing
        if (state.emailController.hasListeners) {
          state.emailController.removeListener(_emailControllerListener);
          state.emailController.dispose();
        }
        if (state.passwordController.hasListeners) {
          state.passwordController.removeListener(_passwordControllerListener);
          state.passwordController.dispose();
        }
      } catch (e) {
        // Ignore errors if controllers are already disposed
      }
    }
    return super.close();
  }
}
