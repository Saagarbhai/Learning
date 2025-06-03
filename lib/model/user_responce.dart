import "package:learning/core/utils/app_export.dart";

class UsersResponse {
  final List<User> users;
  final int total;
  final int skip;
  final int limit;

  UsersResponse({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return UsersResponse(
      users: (json['users'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
