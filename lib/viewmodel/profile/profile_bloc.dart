import '../../core/utils/app_export.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<NameChanged>(_onNameChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<EmailChanged>(_onEmailChanged);
    on<StreetChanged>(_onStreetChanged);
    on<CityChanged>(_onCityChanged);
    on<DistrictChanged>(_onDistrictChanged);
    on<ProfileImageChanged>(_onProfileImageChanged);
    on<ProfileSubmitted>(_onProfileSubmitted);
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
