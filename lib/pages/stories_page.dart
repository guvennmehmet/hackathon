import 'package:flutter/material.dart';
import 'package:hackathon/data/stories.dart';
import 'package:hackathon/widgets/story_card.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hikayeler"),
      ),
      body: ListView.builder(
        itemCount: sampleStories.length,
        itemBuilder: (context, index) {
          return StoryCard(story: sampleStories[index]);
        },
      ),
    );
  }
}