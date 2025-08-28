import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  // 🔹 Helper decode JSON
  static Map<String, dynamic> _json(http.Response r) {
    try {
      final d = jsonDecode(r.body);
      return d is Map<String, dynamic> ? d : {"message": "Invalid response"};
    } catch (_) {
      return {"message": "Gagal decode response"};
    }
  }

  // 🔹 REGISTER
  static Future<Map<String, dynamic>> register(
    String nama,
    String email,
    String password,
  ) async {
    final r = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Accept": "application/json"},
      body: {"nama": nama, "email": email, "password": password},
    );
    return _json(r);
  }

  // 🔹 LOGIN
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final r = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Accept": "application/json"},
      body: {"email": email, "password": password},
    );

    final data = _json(r);

    String? token;
    if (r.statusCode == 200) {
      if (data['token'] != null) {
        token = data['token'];
      } else if (data['access_token'] != null) {
        token = data['access_token'];
      } else if (data['data'] != null && data['data']['access_token'] != null) {
        token = data['data']['access_token'];
      }
    }

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);

      // simpan nama user juga
      final user = data['user'] ?? data['data']?['user'] ?? {};
      final nama = user['nama'] ?? user['name'] ?? '';
      await prefs.setString("nama", nama);
    }
    return data;
  }

  // 🔹 GANTI PASSWORD
  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final r = await http.post(
      Uri.parse("$baseUrl/change-password"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      body: {
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      },
    );

    final data = _json(r);
    data['status'] = r.statusCode;
    return data;
  }

  // 🔹 LOGOUT
  static Future<void> logout() async {
    final token = await getToken();
    if (token != null) {
      await http.post(
        Uri.parse("$baseUrl/logout"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("nama");
  }

  // Ambil token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  // Ambil nama
  static Future<String?> getNama() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("nama");
  }

  // Cek login
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
