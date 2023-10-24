import 'package:flutter/material.dart';
import 'package:hackathon/models/story.dart';

class StoryDetailPage extends StatelessWidget {
  final Story story;

  const StoryDetailPage({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.storyTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(story.storyContent),
      ),
    );
  }
}
