import '../../core/utils/app_export.dart';
import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {
  final int currentPage;

  const OnboardingInitial({this.currentPage = 0});

  @override
  List<Object> get props => [currentPage];
}

class OnboardingInProgress extends OnboardingState {
  final int currentPage;
  final bool isLastPage;

  const OnboardingInProgress({
    required this.currentPage,
    this.isLastPage = false,
  });

  @override
  List<Object> get props => [currentPage, isLastPage];
}

class OnboardingFinished extends OnboardingState {
  const OnboardingFinished();
}

class PageStateChanged extends OnboardingState {
  final int currentPage;

  const PageStateChanged(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
