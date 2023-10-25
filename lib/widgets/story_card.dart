import 'package:flutter/material.dart';
import 'package:hackathon/models/story.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.pink,
          width: 2.0,
        ),
      ),
      child: ListTile(
        title: Text(story.storyTitle),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/story-detail',
            arguments: story,
          );
        },
        trailing: const Icon(
            Icons.arrow_forward_ios,
          color: Colors.purple,
        ),
      ),
    );
  }
}
