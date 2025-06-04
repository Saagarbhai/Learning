class LoginModel {
  final bool status;
  final String message;
  final UserData? data;
  final String? token;

  LoginModel({
    required this.status,
    required this.message,
    this.data,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    // Handle the DummyJSON API response structure
    if (json.containsKey('users') && json['users'] is List) {
      return LoginModel(
        status: true,
        message: 'Login successful',
        data: json['users'].isNotEmpty
            ? UserData.fromJson(json['users'][0])
            : null,
        token: 'dummy-token',
      );
    }

    // If a single user is returned
    if (json.containsKey('id')) {
      return LoginModel(
        status: true,
        message: 'Login successful',
        data: UserData.fromJson(json),
        token: 'dummy-token',
      );
    }

    // Default case or error
    return LoginModel(
      status: json['status'] ?? false,
      message: json['message'] ?? 'Invalid credentials',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
      'token': token,
    };
  }
}

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? image;
  final String username;
  final String password;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.image,
    required this.username,
    required this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    // Handle DummyJSON user structure
    return UserData(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'username': username,
      'password': password,
    };
  }

  String get fullName => '$firstName $lastName';
}
