import "package:learning/core/utils/app_export.dart";
import 'package:dio/dio.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {'Content-Type': 'application/json'},
        )) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: true,
      maxWidth: 90,
    ));
  }

  // Fetch all users
  Future<UsersResponse> fetchUsers() async {
    try {
      final response = await _dio.get('/users');
      return UsersResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch users: ${e.message}');
    }
  }

  // Login with email and password
  Future<User?> login(String email, String password) async {
    try {
      final usersResponse = await fetchUsers();

      final user = usersResponse.users.firstWhere(
        (user) => user.email == email && user.password == password,
        orElse: () => throw Exception('Invalid credentials'),
      );

      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Get user by ID
  Future<User> getUserById(int id) async {
    try {
      final response = await _dio.get('/users/$id');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch user: ${e.message}');
    }
  }

  // Search users by query
  Future<UsersResponse> searchUsers(String query) async {
    try {
      final response = await _dio.get('/users/search', queryParameters: {
        'q': query,
      });

      return UsersResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to search users: ${e.message}');
    }
  }
}
