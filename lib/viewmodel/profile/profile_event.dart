import '../../core/utils/app_export.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends ProfileEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class PhoneChanged extends ProfileEvent {
  final String phone;

  const PhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class EmailChanged extends ProfileEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class StreetChanged extends ProfileEvent {
  final String street;

  const StreetChanged(this.street);

  @override
  List<Object> get props => [street];
}

class CityChanged extends ProfileEvent {
  final String city;

  const CityChanged(this.city);

  @override
  List<Object> get props => [city];
}

class DistrictChanged extends ProfileEvent {
  final String district;

  const DistrictChanged(this.district);

  @override
  List<Object> get props => [district];
}

class ProfileImageChanged extends ProfileEvent {
  final String imagePath;

  const ProfileImageChanged(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class ProfileSubmitted extends ProfileEvent {}

class NavigateToHome extends ProfileEvent {}
