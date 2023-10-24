import 'package:flutter/material.dart';
import 'package:hackathon/models/story.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(story.storyTitle),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/story-detail',
            arguments: story,
          );
        },
      ),
    );
  }
}