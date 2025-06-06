import '../../core/utils/app_export.dart';

class ProfileState extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String street;
  final String city;
  final String district;
  final String? profileImagePath;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isImageLoading;
  final String? errorMessage;
  final List<String> cities;
  final List<String> districts;
  final GlobalKey<FormState> formKey;

  ProfileState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.street = '',
    this.city = '',
    this.district = '',
    this.profileImagePath,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isImageLoading = false,
    this.errorMessage,
    this.cities = const [
      'Ahmedabad',
      'Surat',
      'Vadodara',
      'Rajkot',
      'Bhavnagar',
      'Jamnagar',
      'Junagadh',
      'Gandhinagar',
      'Anand',
      'Nadiad'
    ],
    this.districts = const [
      'Ahmedabad',
      'Surat',
      'Vadodara',
      'Rajkot',
      'Bhavnagar',
      'Jamnagar',
      'Junagadh',
      'Gandhinagar',
      'Anand',
      'Kheda',
      'Mehsana',
      'Patan',
      'Banaskantha',
      'Sabarkantha',
      'Kutch'
    ],
    GlobalKey<FormState>? formKey,
  }) : this.formKey = formKey ?? KeysManager.createProfileFormKey();

  ProfileState copyWith({
    String? name,
    String? phone,
    String? email,
    String? street,
    String? city,
    String? district,
    String? profileImagePath,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isImageLoading,
    String? errorMessage,
    List<String>? cities,
    List<String>? districts,
  }) {
    return ProfileState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      street: street ?? this.street,
      city: city ?? this.city,
      district: district ?? this.district,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      errorMessage: errorMessage,
      cities: cities ?? this.cities,
      districts: districts ?? this.districts,
      formKey: formKey,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        street,
        city,
        district,
        profileImagePath,
        isSubmitting,
        isSuccess,
        isImageLoading,
        errorMessage,
        cities,
        districts,
        formKey,
      ];
}
