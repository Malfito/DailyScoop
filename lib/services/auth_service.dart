import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/signup_request.dart';
import '../models/otp_verification_request.dart';

class AuthService {
  // Replace with your backend URL
  static const String baseUrl = 'http://your-backend-url.com';

  static Future<http.Response> signup(SignupRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    return response;
  }

  static Future<http.Response> verifyOtp(OtpVerificationRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response;
  }

  static Future<http.Response> googleSignIn(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/google-signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );
    return response;
  }

  static Future<http.Response> resendOtp(String phone) async {
    // Depending on your backend, this endpoint might differ.
    final response = await http.post(
      Uri.parse('$baseUrl/api/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );
    return response;
  }
}
