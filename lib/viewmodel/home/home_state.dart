abstract class HomeState {
  final String userName;
  final String userEmail;
  final String userImage;

  const HomeState({
    this.userName = '',
    this.userEmail = '',
    this.userImage = '',
  });
}

class HomeInitial extends HomeState {
  const HomeInitial() : super();
}

class HomeLoading extends HomeState {
  const HomeLoading({
    super.userName,
    super.userEmail,
    super.userImage,
  });
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required String userName,
    required String userEmail,
    required String userImage,
  }) : super(
          userName: userName,
          userEmail: userEmail,
          userImage: userImage,
        );
}

class HomeError extends HomeState {
  final String message;

  const HomeError(
    this.message, {
    super.userName,
    super.userEmail,
    super.userImage,
  });
}
