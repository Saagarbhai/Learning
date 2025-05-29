import '../../core/utils/app_export.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashCompleted extends SplashState {
  const SplashCompleted();
}

class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);

  @override
  List<Object> get props => [message];
}
