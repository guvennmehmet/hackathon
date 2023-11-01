import 'package:flutter/material.dart';
import 'package:hackathon/components/scroll_back_to_top_button.dart';
import 'package:hackathon/models/story.dart';
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

  @override
  void initState() {
    super.initState();
    findAppBarColor();
    favoriteBox = Hive.box<Story>('favoriteStories');
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
            icon: const Icon(Icons.volume_up_sharp),
            onPressed: () {},
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 8.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Image.asset(
                      'assets/images/${widget.story.storyImage}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.story.storyTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  widget.story.storyContent,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
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
