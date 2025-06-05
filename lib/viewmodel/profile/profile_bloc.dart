import '../../core/utils/app_export.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // Use the key from KeysManager
  final formKey = KeysManager.profileFormKey;

  ProfileBloc() : super(ProfileState()) {
    on<InitializeProfile>(_onInitializeProfile);
    on<NameChanged>(_onNameChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<EmailChanged>(_onEmailChanged);
    on<StreetChanged>(_onStreetChanged);
    on<CityChanged>(_onCityChanged);
    on<DistrictChanged>(_onDistrictChanged);
    on<ProfileImageChanged>(_onProfileImageChanged);
    on<ProfileSubmitted>(_onProfileSubmitted);
    on<NavigateToHome>(_onNavigateToHome);
  }

  void _onInitializeProfile(
      InitializeProfile event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      name: event.name ?? state.name,
      email: event.email ?? state.email,
      profileImagePath: event.imagePath ?? state.profileImagePath,
    ));
  }

  void _onNameChanged(NameChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      name: event.name,
      errorMessage: null, // Clear previous error messages
    ));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      phone: event.phone,
      errorMessage: null,
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      email: event.email,
      errorMessage: null,
    ));
  }

  void _onStreetChanged(StreetChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      street: event.street,
      errorMessage: null,
    ));
  }

  void _onCityChanged(CityChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      city: event.city,
      errorMessage: null,
    ));
  }

  void _onDistrictChanged(DistrictChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      district: event.district,
      errorMessage: null,
    ));
  }

  void _onProfileImageChanged(
      ProfileImageChanged event, Emitter<ProfileState> emit) async {
    // First set loading state to true
    emit(state.copyWith(
      isImageLoading: true,
      errorMessage: null, // Clear previous error messages
    ));

    try {
      // Simulate image processing delay (you can remove this in production)
      await Future.delayed(const Duration(milliseconds: 300));

      // Update state with new image path and set loading to false
      emit(state.copyWith(
        profileImagePath: event.imagePath,
        isImageLoading: false,
      ));
    } catch (e) {
      // Handle any errors
      emit(state.copyWith(
        isImageLoading: false,
        errorMessage: 'Failed to load image',
      ));
    }
  }

  void _onProfileSubmitted(
      ProfileSubmitted event, Emitter<ProfileState> emit) async {
    // Validate the name (required field)
    if (state.name.trim().isEmpty) {
      emit(state.copyWith(
        errorMessage: 'Please enter your name',
      ));
      return;
    }

    // If validation passes, proceed with submission
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      // Save user data to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', state.name);
      await prefs.setString('user_email', state.email);

      // Save profile image path if available
      if (state.profileImagePath != null &&
          state.profileImagePath!.isNotEmpty) {
        await prefs.setString('user_image', state.profileImagePath!);
      }

      // Simulate API call to save profile
      await Future.delayed(const Duration(seconds: 1));

      // Profile saved successfully
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'An error occurred during submission',
      ));
    }
  }

  void _onNavigateToHome(NavigateToHome event, Emitter<ProfileState> emit) {
    // This event will be handled by the BlocListener in the UI
    // No state changes needed here, just trigger the event
  }
}
