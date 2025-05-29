import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingPageChanged extends OnboardingEvent {
  final int page;

  const OnboardingPageChanged(this.page);

  @override
  List<Object> get props => [page];
}

class OnboardingSkipped extends OnboardingEvent {
  const OnboardingSkipped();
}

class OnboardingCompleted extends OnboardingEvent {
  const OnboardingCompleted();
}

class NextPageEvent extends OnboardingEvent {}

class PreviousPageEvent extends OnboardingEvent {}

class GoToPageEvent extends OnboardingEvent {
  final int pageIndex;

  const GoToPageEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}
