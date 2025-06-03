import "package:learning/core/utils/app_export.dart";

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  final int total;

  UsersLoaded({required this.users, required this.total});
}

class UserLoggedIn extends UsersState {
  final User user;

  UserLoggedIn({required this.user});
}

class UserLoggedOut extends UsersState {}

class SingleUserLoaded extends UsersState {
  final User user;

  SingleUserLoaded({required this.user});
}

class UsersSearchLoaded extends UsersState {
  final List<User> users;
  final String query;

  UsersSearchLoaded({required this.users, required this.query});
}

class UsersError extends UsersState {
  final String message;

  UsersError({required this.message});
}
