import 'package:flutter/material.dart';
import 'package:hackathon/components/scroll_back_to_top_button.dart';
import 'package:hackathon/service/ai_translate_service.dart';
import 'package:hackathon/widgets/story_view.dart';
import 'package:hackathon/models/story.dart';

const apiKey = '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';

class TranslationPage extends StatefulWidget {
  final Story story;
  final ScrollController? scrollController;

  const TranslationPage({Key? key, required this.story, this.scrollController}) : super(key: key);

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  String translatedTitle = '';
  String translatedContent = '';

  @override
  void initState() {
    super.initState();
    translateText('en', widget.story).then((result) {
      setState(() {
        translatedTitle = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translated Story'),
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
      floatingActionButton: widget.scrollController != null
          ? BackToTopButton(controller: widget.scrollController!)
          : null,
    );
  }
}
