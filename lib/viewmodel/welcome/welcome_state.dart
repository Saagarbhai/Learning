import 'package:learning/core/utils/app_export.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object> get props => [];
}

class WelcomeInitial extends WelcomeState {}

class NavigateToCreateAccount extends WelcomeState {}

class NavigateToLogin extends WelcomeState {}
