import '../../core/utils/app_export.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      // Add your home data loading logic here
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay
      emit(HomeLoaded());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      // Add your refresh logic here
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay
      emit(HomeLoaded());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
