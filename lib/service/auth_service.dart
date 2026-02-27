import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../core/api_end_points.dart';

/// This is the class responsible for talk with the backend that hey this app need data and call the backed to get data
/// Initially i use the try-case block i know it can be better error handling in future
class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<bool> login(String name, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': name, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final token = data['token'];
        if (token != null) {
          await _storage.write(key: 'access_token', value: token);
        }
        return true;
      } else {
        final error = jsonDecode(response.body);
        print(response.statusCode);
        print(error);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
