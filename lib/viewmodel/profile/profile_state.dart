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
  final String? errorMessage;

  const ProfileState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.street = '',
    this.city = '',
    this.district = '',
    this.profileImagePath,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

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
    String? errorMessage,
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
      errorMessage: errorMessage,
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
        errorMessage,
      ];
}
