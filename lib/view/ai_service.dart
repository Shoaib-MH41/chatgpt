import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AIService {
  static late String baseUrl;

  /// 🔹 Step 1: Load baseUrl from config.json
  static Future<void> init() async {
    try {
      // project root سے config.json لوڈ کریں
      final file = File('config.json');
      if (await file.exists()) {
        final config = json.decode(await file.readAsString());
        baseUrl = config['baseUrl'];
      } else {
        throw Exception('config.json file not found');
      }
    } catch (e) {
      throw Exception('Error loading config: $e');
    }
  }

  /// 🔹 Step 2: Send message to AI API
  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['response'] ?? 'No response from AI';
      } else {
        return 'AI Service Temporarily Unavailable (${response.statusCode})';
      }
    } catch (e) {
      return 'Connection failed: $e';
    }
  }
}
