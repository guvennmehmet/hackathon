import 'package:http/http.dart' as http;
import 'dart:convert';

class AIStoryService {
  static const String apiKey = '';
  static const String model = 'gpt-3.5-turbo-instruct';

  static Future<List<String>> generateStory(String prompt, int length) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      'model': model,
      'prompt': prompt,
      'temperature': 0.9,
      'max_tokens': length,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0.6,
      'stop': [" Human:", " AI:"]
    };

    final Uri uri = Uri.parse('https://api.openai.com/v1/completions');

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final generatedStory = data['choices'][0]['text'];
      var fixedStory = fixCharacterEncoding(generatedStory);
      final fixedStoryTitle = takeTheTitle(fixedStory);
      fixedStory= fixedStory.substring(fixedStory.indexOf(")") + 1, fixedStory.length);
      print("fixedStory: $fixedStory");
      return [fixedStory, fixedStoryTitle];
    } else {
      throw Exception('Hikaye oluşturma hatası: ${response.reasonPhrase}');
    }
  }

  static String takeTheTitle(String text) {
    final title = text.substring(text.indexOf("(") + 1, text.indexOf(')'));
    return title;
  }

  static String fixCharacterEncoding(String text) {
    return utf8.decode(const Latin1Codec().encode(text));
  }
}
