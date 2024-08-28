import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackathon/models/story.dart';

const apiKey = 'XXXXXXXXXXXXXXXX';

Future<String> translateText(String targetLang, Story story) async {
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  final content =
      "Translate the following text from Turkish to English: ${story.storyTitle} ${story.storyContent}";
  final translatedStory = "${story.storyTitle} \n ${story.storyContent}";

  final Map<String, dynamic> requestBody = {
    'model': 'gpt-4',
    'messages': [
      {'role': 'system', 'content': content},
      {'role': 'assistant', 'content': translatedStory}
    ],
    'temperature': 0,
    'max_tokens': 3000,
    'top_p': 1,
    'frequency_penalty': 0,
    'presence_penalty': 0.6
  };
  final response = await http.post(url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final translatedText = data['choices'][0]['message']['content'];
    return translatedText;
  } else {
    throw Exception('Çeviri başarısız: ${response.reasonPhrase}');
  }
}
