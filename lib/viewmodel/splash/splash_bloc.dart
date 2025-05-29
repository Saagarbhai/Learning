import '../../core/utils/app_export.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
    on<SplashTimerCompleted>(_onSplashTimerCompleted);
  }

  Timer? _splashTimer;

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    // Start a timer for 3 seconds
    _splashTimer = Timer(const Duration(milliseconds: 1500), () {
      add(const SplashTimerCompleted());
    });
  }

  Future<void> _onSplashTimerCompleted(
    SplashTimerCompleted event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashCompleted());
  }

  @override
  Future<void> close() {
    _splashTimer?.cancel();
    return super.close();
  }
}
