import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio = Dio();
  final String baseUrl = "http://loaclhost:6969";

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  DioClient() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30); // 10s timeout
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final cookie =
            response.headers['set-cookie']; // Extract Set-Cookie header
        final userData = responseData['data'];

        if (cookie != null) {
          // Save session cookie
          await saveSession(
              cookie.first); // Storing the first cookie (if multiple)
        }

        print("Login successful: $userData");
      } else {
        print("Login failed: ${response.statusMessage}");
      }
    } catch (error) {
      print("Error logging in: $error");
    }
  }

  // Save session cookie securely
  Future<void> saveSession(String cookie) async {
    await _storage.write(key: 'sessionCookie', value: cookie);
  }

  // Get session cookie
  Future<String?> getSessionCookie() async {
    return await _storage.read(key: 'sessionCookie');
  }

  // Fetch data with session cookie
  Future<void> fetchData() async {
    final cookie = await getSessionCookie();

    if (cookie == null) {
      print("No session cookie found. Please login.");
      return;
    }

    try {
      final response = await _dio.get(
        '/protected-endpoint', // Replace with your actual endpoint
        options: Options(
          headers: {
            'Cookie': cookie, // Attach the session cookie in headers
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Data fetched: ${response.data}");
      } else {
        print("Failed to fetch data: ${response.statusMessage}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  // Logout method (optional)
  Future<void> logout() async {
    await _storage.delete(key: 'sessionCookie');
    print("Logged out successfully.");
  }
}
