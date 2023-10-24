import 'package:flutter/material.dart';
import 'package:hackathon/models/story.dart';
import 'package:hackathon/pages/stories_page.dart';
import 'package:hackathon/pages/story_detail_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const StoriesPage());
      case '/story-detail':
        final args = settings.arguments as Story;
        return MaterialPageRoute(builder: (_) => StoryDetailPage(story: args));
      default:
        return MaterialPageRoute(builder: (_) => const StoriesPage());
    }
  }
}