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

class BioChanged extends ProfileEvent {
  final String bio;

  const BioChanged(this.bio);

  @override
  List<Object> get props => [bio];
}

class LocationChanged extends ProfileEvent {
  final String location;

  const LocationChanged(this.location);

  @override
  List<Object> get props => [location];
}

class ProfileImageChanged extends ProfileEvent {
  final String imagePath;

  const ProfileImageChanged(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class ProfileSubmitted extends ProfileEvent {}
