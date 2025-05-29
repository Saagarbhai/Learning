import 'package:learning/core/utils/app_export.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<CreateAccountPressed>((event, emit) {
      emit(NavigateToCreateAccount());
    });

    on<LogInPressed>((event, emit) {
      emit(NavigateToLogin());
    });

    on<ResetWelcomeState>((event, emit) {
      emit(WelcomeInitial());
    });
  }
}
