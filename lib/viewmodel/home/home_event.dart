abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class RefreshHomeData extends HomeEvent {}

class LoadUserData extends HomeEvent {}

class LogoutUser extends HomeEvent {}

class SetUserData extends HomeEvent {
  final String name;
  final String email;
  final String imagePath;

  SetUserData({
    required this.name,
    required this.email,
    required this.imagePath,
  });
}
