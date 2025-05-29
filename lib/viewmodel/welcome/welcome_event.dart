import 'package:learning/core/utils/app_export.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class CreateAccountPressed extends WelcomeEvent {}

class LogInPressed extends WelcomeEvent {}

class ResetWelcomeState extends WelcomeEvent {}
