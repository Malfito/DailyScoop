import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/OnboardingRequestModel.dart';
import '../strings/Strings.dart';

class OnboardingService {
  static Future<bool> submitOnboarding(OnboardingRequestModel model) async {
    final url = Uri.parse("${AppUrls.baseUrl}/api/onboarding/submit"); // yahi pattern har API me

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Success: ${response.body}");
        return true;
      } else {
        print("❌ Failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🔥 Error: $e");
      return false;
    }
  }
}
