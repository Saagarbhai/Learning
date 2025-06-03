import '../../core/utils/app_export.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ApiService _apiService = ApiService();
  final formKey = KeysManager.signInFormKey;

  // Move controllers to bloc level
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    emailController.addListener(_emailControllerListener);
    passwordController.addListener(_passwordControllerListener);
  }

  void _emailControllerListener() {
    add(UpdateEmail(emailController.text));
  }

  void _passwordControllerListener() {
    add(UpdatePassword(passwordController.text));
  }

  void _onInitializeSignIn(InitializeSignIn event, Emitter<SignInState> emit) {
    emit(SignInState(
      emailController: emailController,
      passwordController: passwordController,
    ));
  }

  void _onDisposeSignIn(DisposeSignIn event, Emitter<SignInState> emit) {
    // Don't dispose controllers here, they will be disposed in close()
    emit(SignInState(
      emailController: emailController,
      passwordController: passwordController,
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
      // For other users, try the API
      final user = await _apiService.login(event.email, event.password);

      // If login is successful, the login method will return a user
      if (user != null) {
        emit(state.copyWith(isLoading: false, isSignInSuccess: true));
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
    emit(SignInState.initial());
  }

  @override
  Future<void> close() {
    // Remove listeners
    emailController.removeListener(_emailControllerListener);
    passwordController.removeListener(_passwordControllerListener);

    // Dispose controllers
    emailController.dispose();
    passwordController.dispose();

    return super.close();
  }
}
