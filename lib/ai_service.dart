import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String baseUrl = 'http://192.168.1.47:8080';
  
  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': message}),
      );
      
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return data['response'];
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Connection failed: $e';
    }
  }
}
