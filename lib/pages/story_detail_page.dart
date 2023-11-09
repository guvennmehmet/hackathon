import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hackathon/components/scroll_back_to_top_button.dart';
import 'package:hackathon/models/story.dart';
import 'package:hackathon/pages/translation_page.dart';
import 'package:hackathon/widgets/story_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palette_generator/palette_generator.dart';

class StoryDetailPage extends StatefulWidget {
  final Story story;
  final ScrollController scrollController;

  const StoryDetailPage({
    Key? key,
    required this.story,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  Color appBarColor = Colors.transparent;
  late PaletteGenerator _generator;
  bool isFavorite = false;
  late Box<Story> favoriteBox;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    findAppBarColor();
    favoriteBox = Hive.box<Story>('favoriteStories');
  }

  speak() async {
    await flutterTts.setLanguage("tr-TR");
    await flutterTts.setPitch(1);
    await flutterTts.speak(widget.story.storyContent);
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
        title: Text(widget.story.storyTitle),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TranslationPage(story: widget.story),
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.volume_up_sharp),
            onPressed: () {
              speak();
            },
          ),
          IconButton(
            icon: widget.story.isFavorite
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              setState(() {
                widget.story.isFavorite = !widget.story.isFavorite;
                if (widget.story.isFavorite) {
                  final favoriteBox = Hive.box<Story>('favoriteStories');
                  favoriteBox.add(widget.story);
                } else {
                  final favoriteBox = Hive.box<Story>('favoriteStories');
                  favoriteBox.delete(widget.story.key);
                }
              });
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
          controller: widget.scrollController,
          child: StoryView(
            storyImage: widget.story.storyImage,
            translatedTitle: widget.story.storyTitle,
            translatedContent: widget.story.storyContent,
          ),
        ),
      ),
      floatingActionButton:
      BackToTopButton(controller: widget.scrollController),
    );
  }

  void findAppBarColor() async {
    _generator = await PaletteGenerator.fromImageProvider(
        AssetImage('assets/images/${widget.story.storyImage}'));
    appBarColor = _generator.vibrantColor!.color;
    setState(() {});
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
