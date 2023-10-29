import 'package:flutter/material.dart';
import 'package:hackathon/widgets/story_card.dart';
import 'package:hive/hive.dart';
import 'package:hackathon/models/story.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Box<Story> favoriteBox;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box<Story>('favoriteStories');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoriler"),
      ),
      body: ListView.builder(
        itemCount: favoriteBox.length,
        itemBuilder: (context, index) {
          final story = favoriteBox.getAt(index)!;
          if (story.isFavorite) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: StoryCard(story: story),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void refreshFavorites() {
    setState(() {});
  }

}
