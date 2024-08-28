import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hackathon/components/scroll_back_to_top_button.dart';
import 'package:hackathon/models/story.dart';
import 'package:hackathon/service/ai_translate_service.dart';

const apiKey = 'XXXXXXXXXXXXXXXX';

class AiTranslationPage extends StatefulWidget {
  final Story story;
  final ScrollController? scrollController;

  const AiTranslationPage({Key? key, required this.story, this.scrollController}) : super(key: key);

  @override
  State<AiTranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<AiTranslationPage> {
  String translatedTitle = '';
  String translatedContent = '';
  var isStoryGenerated = false;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();

    translateText('en', widget.story).then((result) {
      setState(() {
        translatedTitle = result.substring(0, result.indexOf('\n'));
        translatedContent = result.substring(result.indexOf('\n'), result.length);
        isStoryGenerated = true;
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
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  translatedTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              isStoryGenerated ? Padding(
                padding: const EdgeInsets.all(24),
                child: GestureDetector(
                  child: Text(
                    translatedContent,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ): const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.scrollController != null
          ? BackToTopButton(controller: widget.scrollController!)
          : null,
    );
  }
}