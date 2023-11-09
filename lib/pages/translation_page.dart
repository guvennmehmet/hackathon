import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hackathon/service/ai_translate_service.dart';
import 'package:hackathon/widgets/story_view.dart';
import 'package:hackathon/models/story.dart';

const apiKey = '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';

class TranslationPage extends StatefulWidget {
  final Story story;

  const TranslationPage({Key? key, required this.story}) : super(key: key);

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  String translatedTitle = '';
  String translatedContent = '';
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    translateText('en', widget.story).then((result) {
      setState(() {
        translatedTitle = result.substring(0, result.indexOf('\n'));
        translatedContent = result.substring(result.indexOf('\n'), result.length);
      });
    });
  }

  speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(translatedContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translated Story'),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              speak();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: StoryView(
              storyImage: widget.story.storyImage,
              translatedTitle: translatedTitle,
              translatedContent: translatedContent,
            ),
          ),
        ),
      ),
    );
  }
}
