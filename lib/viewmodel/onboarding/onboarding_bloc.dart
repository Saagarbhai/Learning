import 'package:learning/core/utils/app_export.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  static const int totalPages = 3;

  OnboardingBloc() : super(const OnboardingInitial()) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingSkipped>(_onSkipped);
    on<OnboardingCompleted>(_onCompleted);
    on<NextPageEvent>(_onNextPage);
  }

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    final isLastPage = event.page == totalPages - 1;
    emit(OnboardingInProgress(
      currentPage: event.page,
      isLastPage: isLastPage,
    ));
  }

  void _onSkipped(
    OnboardingSkipped event,
    Emitter<OnboardingState> emit,
  ) {
    emit(const OnboardingFinished());
  }

  void _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) {
    emit(const OnboardingFinished());
  }

  void _onNextPage(
    NextPageEvent event,
    Emitter<OnboardingState> emit,
  ) {
    // Get current state to determine current page
    final currentState = state;
    if (currentState is OnboardingInProgress) {
      final nextPage = currentState.currentPage + 1;
      if (nextPage < totalPages) {
        final isLastPage = nextPage == totalPages - 1;
        emit(OnboardingInProgress(
          currentPage: nextPage,
          isLastPage: isLastPage,
        ));
      } else {
        // If we've gone beyond the last page, emit OnboardingFinished
        emit(const OnboardingFinished());
      }
    } else {
      // If we're not in OnboardingInProgress, start at page 0
      emit(const OnboardingInProgress(
        currentPage: 0,
        isLastPage: false,
      ));
    }
  }
}
