import 'package:http/http.dart' as http;
import 'dart:convert';

class AIStoryService {
  static const String apiKey = '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';
  static const String model = 'davinci';

  static Future<String> generateStory(String story) async {
    final prompt = story;

    final Map<String, String> headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      'model': model,
      'prompt': prompt,
      'max_tokens': 100,
    };

    final Uri uri = Uri.parse('https://api.openai.com/v1/engines/$model/completions');

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final generatedStory = data['choices'][0]['text'];
      return generatedStory;
    } else {
      throw Exception('Hikaye oluşturma hatası: ${response.reasonPhrase}');
    }
  }
}