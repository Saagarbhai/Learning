import '../../core/utils/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
    on<LoadUserData>(_onLoadUserData);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      // Add your home data loading logic here
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay

      // Load user data as part of home data loading
      final userData = await _getUserData();
      emit(HomeLoaded(
        userName: userData['userName'] ?? 'User',
        userEmail: userData['userEmail'] ?? 'user@example.com',
        userImage: userData['userImage'] ?? '',
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    // Preserve current user data
    final currentState = state;
    emit(HomeLoading(
      userName: currentState.userName,
      userEmail: currentState.userEmail,
      userImage: currentState.userImage,
    ));

    try {
      // Add your refresh logic here
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay

      // Reload user data
      final userData = await _getUserData();
      emit(HomeLoaded(
        userName: userData['userName'] ?? 'User',
        userEmail: userData['userEmail'] ?? 'user@example.com',
        userImage: userData['userImage'] ?? '',
      ));
    } catch (e) {
      emit(HomeError(
        e.toString(),
        userName: currentState.userName,
        userEmail: currentState.userEmail,
        userImage: currentState.userImage,
      ));
    }
  }

  Future<void> _onLoadUserData(
    LoadUserData event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    try {
      final userData = await _getUserData();
      emit(HomeLoaded(
        userName: userData['userName'] ?? 'User',
        userEmail: userData['userEmail'] ?? 'user@example.com',
        userImage: userData['userImage'] ?? '',
      ));
    } catch (e) {
      print('Error loading user data: $e');
      // Keep current state if there's an error
      if (currentState is! HomeLoaded) {
        emit(HomeLoaded(
          userName: 'User',
          userEmail: 'user@example.com',
          userImage: '',
        ));
      }
    }
  }

  Future<void> _onLogoutUser(
    LogoutUser event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _clearUserData();

      // Show success message is handled in the UI
      emit(const HomeInitial());
    } catch (e) {
      print('Error during logout: $e');
      emit(HomeError('Error during logout: $e'));
    }
  }

  // Helper methods
  Future<Map<String, String>> _getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return {
        'userName': prefs.getString('user_name') ?? 'User',
        'userEmail': prefs.getString('user_email') ?? 'user@example.com',
        'userImage': prefs.getString('user_image') ?? '',
      };
    } catch (e) {
      print('Error loading user data: $e');
      return {
        'userName': 'User',
        'userEmail': 'user@example.com',
        'userImage': '',
      };
    }
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('user_image');
  }
}
