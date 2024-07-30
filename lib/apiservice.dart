import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pixel6/usermodel.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<User>> fetchUsers(int limit, int skip) async {
    final response =
        await http.get(Uri.parse('$baseUrl/users?limit=$limit&skip=$skip'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<User> users =
          (data['users'] as List).map((json) => User.fromJson(json)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
