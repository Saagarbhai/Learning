import 'package:learning/core/utils/app_export.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final ApiService _apiService;
  User? _currentUser;

  UsersBloc({required ApiService apiService})
      : _apiService = apiService,
        super(UsersInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<GetUserByIdEvent>(_onGetUserById);
    on<SearchUsersEvent>(_onSearchUsers);
    on<RefreshUsersEvent>(_onRefreshUsers);
  }

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(UsersLoading());
      final usersResponse = await _apiService.fetchUsers();
      emit(UsersLoaded(
        users: usersResponse.users,
        total: usersResponse.total,
      ));
    } catch (e) {
      emit(UsersError(message: e.toString()));
    }
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(UsersLoading());
      final user = await _apiService.login(event.email, event.password);
      if (user != null) {
        _currentUser = user;
        emit(UserLoggedIn(user: user));
      } else {
        emit(UsersError(message: 'Login failed: Invalid credentials'));
      }
    } catch (e) {
      emit(UsersError(message: e.toString()));
    }
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<UsersState> emit,
  ) async {
    _currentUser = null;
    emit(UserLoggedOut());
  }

  Future<void> _onGetUserById(
    GetUserByIdEvent event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(UsersLoading());
      final user = await _apiService.getUserById(event.userId);
      emit(SingleUserLoaded(user: user));
    } catch (e) {
      emit(UsersError(message: e.toString()));
    }
  }

  Future<void> _onSearchUsers(
    SearchUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(UsersLoading());
      final usersResponse = await _apiService.searchUsers(event.query);
      emit(UsersSearchLoaded(
        users: usersResponse.users,
        query: event.query,
      ));
    } catch (e) {
      emit(UsersError(message: e.toString()));
    }
  }

  Future<void> _onRefreshUsers(
    RefreshUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    add(FetchUsersEvent());
  }
}
