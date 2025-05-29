import '../../core/utils/app_export.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class SplashStarted extends SplashEvent {
  const SplashStarted();
}

class SplashTimerCompleted extends SplashEvent {
  const SplashTimerCompleted();
}
