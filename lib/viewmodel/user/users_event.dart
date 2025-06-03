abstract class UsersEvent {}

class FetchUsersEvent extends UsersEvent {}

class LoginEvent extends UsersEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends UsersEvent {}

class GetUserByIdEvent extends UsersEvent {
  final int userId;

  GetUserByIdEvent({required this.userId});
}

class SearchUsersEvent extends UsersEvent {
  final String query;

  SearchUsersEvent({required this.query});
}

class RefreshUsersEvent extends UsersEvent {}
