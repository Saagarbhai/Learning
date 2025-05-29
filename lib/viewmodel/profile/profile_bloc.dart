import '../../core/utils/app_export.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<NameChanged>(_onNameChanged);
    on<BioChanged>(_onBioChanged);
    on<LocationChanged>(_onLocationChanged);
    on<ProfileImageChanged>(_onProfileImageChanged);
    on<ProfileSubmitted>(_onProfileSubmitted);
  }

  void _onNameChanged(NameChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      name: event.name,
      errorMessage: null, // Clear previous error messages
    ));
  }

  void _onBioChanged(BioChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      bio: event.bio,
      errorMessage: null, // Clear previous error messages
    ));
  }

  void _onLocationChanged(LocationChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      location: event.location,
      errorMessage: null, // Clear previous error messages
    ));
  }

  void _onProfileImageChanged(
      ProfileImageChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      profileImagePath: event.imagePath,
      errorMessage: null, // Clear previous error messages
    ));
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
}
