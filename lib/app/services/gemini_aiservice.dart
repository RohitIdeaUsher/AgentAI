import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static String apiKey = dotenv.env['API_KEY'].toString();
  static const String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  /// Generate a response using Gemini API
  static Future<String> generateResponse(String prompt) async {
    try {
      var response = await http.post(
        Uri.parse('$_apiUrl?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var responseText = data['candidates'][0]['content']['parts'][0]['text'];
        return responseText.trim();
      } else {
        return 'Failed to fetch response: ${response.body}';
      }
    } catch (e) {
      return 'Error occurred: $e';
    }
  }
}
