import '../core/utils/app_export.dart';

class AuthRepository {
  final ApiClient apiClient;
  AuthRepository({required this.apiClient});

  Future<LoginModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      // First fetch all users from the API
      final response = await apiClient.request(
        RequestType.GET,
        ApiEndPoint.usersUrl,
      );

      final loginModel = LoginModel.fromJson(response);

      // Check if users data exists
      if (loginModel.data == null) {
        return LoginModel(
          status: false,
          message: 'Failed to fetch users data',
        );
      }

      // Get all users from the response
      final allUsers = response['users'] as List;

      // Find user with matching email/username and password
      final matchingUser = allUsers.firstWhere(
        (user) =>
            // Check if email matches or username matches
            (user['email'] == email || user['username'] == email) &&
            // Check if password matches
            user['password'] == password,
        orElse: () => {},
      );

      // If user was found, return success
      if (matchingUser.isNotEmpty) {
        return LoginModel(
          status: true,
          message: 'Login successful',
          data: UserData.fromJson(matchingUser),
          token: 'dummy-token-${matchingUser['id']}',
        );
      } else {
        // No matching user found
        return LoginModel(
          status: false,
          message: 'Invalid email or password',
        );
      }
    } catch (error) {
      return LoginModel(
        status: false,
        message: error.toString(),
      );
    }
  }
}
