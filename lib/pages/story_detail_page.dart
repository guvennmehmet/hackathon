import 'package:flutter/material.dart';
import 'package:hackathon/models/story.dart';
import 'package:palette_generator/palette_generator.dart';

class StoryDetailPage extends StatefulWidget {
  final Story story;

  const StoryDetailPage({Key? key, required this.story}) : super(key: key);

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  Color appBarColor = Colors.transparent;
  late PaletteGenerator _generator;

  @override
  void initState() {
    super.initState();
    findAppBarColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.storyTitle),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/${widget.story.storyImage}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.story.storyContent,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void findAppBarColor() async {
    _generator = await PaletteGenerator.fromImageProvider(
        AssetImage('assets/images/${widget.story.storyImage}'));
    appBarColor = _generator.vibrantColor!.color;
    setState(() {});
  }
}
