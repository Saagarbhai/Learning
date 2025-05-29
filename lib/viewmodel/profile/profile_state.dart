import '../../core/utils/app_export.dart';

class ProfileState extends Equatable {
  final String name;
  final String bio;
  final String location;
  final String? profileImagePath;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const ProfileState({
    this.name = '',
    this.bio = '',
    this.location = '',
    this.profileImagePath,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ProfileState copyWith({
    String? name,
    String? bio,
    String? location,
    String? profileImagePath,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ProfileState(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        bio,
        location,
        profileImagePath,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}
