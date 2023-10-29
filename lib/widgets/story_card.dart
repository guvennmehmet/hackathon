import 'package:flutter/material.dart';
import 'package:hackathon/models/story.dart';
import 'package:hackathon/pages/story_detail_page.dart';
import 'package:hive/hive.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      child: ListTile(
        title: Text(
          story.storyTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          final scrollController = ScrollController();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StoryDetailPage(
                story: story,
                scrollController: scrollController,
              ),
            ),
          ).then((updatedStory) {
            if (updatedStory != null) {
              if (!updatedStory.isFavorite) {
                final favoriteBox = Hive.box<Story>('favoriteStories');
                favoriteBox.delete(updatedStory.key);
              }
            }
          });
        },
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
