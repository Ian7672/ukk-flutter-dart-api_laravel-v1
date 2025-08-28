// lib/models/user.dart
class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? token; // opsional, dipakai saat login

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.token,
  });

  // Konversi dari JSON ke object User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      token: json['token'], // biasanya dikirim API saat login
    );
  }

  // Konversi dari object User ke JSON (untuk register)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'token': token,
    };
  }
}
