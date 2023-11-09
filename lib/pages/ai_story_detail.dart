import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hackathon/components/scroll_back_to_top_button.dart';
import 'package:hackathon/models/story.dart';
import 'package:hackathon/service/ai_story_service.dart';
import 'package:hive/hive.dart';

import 'ai_translation_page.dart';



class AiStoryDetailPage extends StatefulWidget {
  final String subject;
  final String time;
  final int length;
  const AiStoryDetailPage({super.key, required this.subject, required this.time, required this.length}) ;

  @override
  State<AiStoryDetailPage> createState() => _AiStoryDetailPageState();
}

class _AiStoryDetailPageState extends State<AiStoryDetailPage> {
  final ScrollController scrollController = ScrollController();
  String generatedStoryUI = "";
  String generatedStoryTitle = "";
  Color appBarColor = Colors.transparent;
  bool isFavorite = false;
  late Box<Story> favoriteBox;
  bool isStoryGenerated = false;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box<Story>('favoriteStories');
    generateStory();
  }

  speak() async {
    await flutterTts.setLanguage("tr-TR");
    await flutterTts.setPitch(1);
    await flutterTts.speak(generatedStoryUI);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            removeUnfavoritedStories();
            Navigator.of(context).pop();
          },
        ),
        title: Text(generatedStoryTitle),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AiTranslationPage(story: Story(storyTitle: generatedStoryTitle, storyContent: generatedStoryUI, storyID: -1, storyImage: ''))),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.volume_up_sharp),
            onPressed: () {
              speak();
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Text(
                generatedStoryTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              isStoryGenerated ? Padding(
                padding: const EdgeInsets.all(24),
                child: GestureDetector(
                  child: Text(
                    generatedStoryUI,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ): const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      floatingActionButton: BackToTopButton(controller: scrollController),
    );
  }
  Future<void> generateStory() async {
    final subject = widget.subject;
    final time = widget.time;
    final length = widget.length;

    final story = "$subject ile ilgili $time zamanlarında geçen ${length/2} kelimelik bir hikaye oluştur. Başlığı ilk cümle olarak parantez içinde kullan. ";

    final generatedStory= await AIStoryService.generateStory(story, length);

    print("generatedStory: ${generatedStory[0]}");

    setState(() {
      isStoryGenerated = true;
      generatedStoryUI = generatedStory[0];
      generatedStoryTitle = generatedStory[1];
    });
  }

  void refreshFavorites() {
    setState(() {
      final favoriteStoriesBox = Hive.box<Story>('favoriteStories');
      favoriteStoriesBox.values.toList().forEach((story) {
        if (!story.isFavorite) {
          favoriteStoriesBox.delete(story.key);
        }
      });
    });
  }

  void removeUnfavoritedStories() {
    for (int index = favoriteBox.length - 1; index >= 0; index--) {
      final story = favoriteBox.getAt(index)!;
      if (!story.isFavorite) {
        favoriteBox.deleteAt(index);
      }
    }
  }
}