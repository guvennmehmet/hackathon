import 'package:flutter/material.dart';
import 'package:hackathon/models/story.dart';
import 'package:hackathon/pages/ai_story_detail.dart';
import 'package:hackathon/pages/stories_page.dart';
import 'package:hackathon/pages/story_detail_page.dart';

class Routes {
  static late ScrollController scrollController;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const StoriesPage());
      case '/story-detail':
        final args = settings.arguments as Story;
        return MaterialPageRoute(
            builder: (_) => StoryDetailPage(
                story: args, scrollController: scrollController));
      case '/favorite-story-detail':
        final args = settings.arguments as Story; // Assuming you have a FavoriteStory model
        return MaterialPageRoute(
            builder: (_) => StoryDetailPage(
                story: args, scrollController: scrollController));
      case '/ai-story-detail':
        final args = settings.arguments as Map<String, String>; // Map ile argümanı al
        return MaterialPageRoute(
            builder: (_) => AiStoryDetailPage(
                subject: args['subject'] as String,
                character: args['character'] as String));
      default:
        return MaterialPageRoute(builder: (_) => const StoriesPage());
    }
  }
}
