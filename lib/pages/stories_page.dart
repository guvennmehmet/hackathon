import 'package:flutter/material.dart';
import 'package:hackathon/components/scroll_back_to_top_button.dart';
import 'package:hackathon/data/stories.dart';
import 'package:hackathon/widgets/story_card.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hikayeler"),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: sampleStories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: StoryCard(story: sampleStories[index]),
          );
        },
      ),
      floatingActionButton: BackToTopButton(controller: scrollController),
    );
  }
}
