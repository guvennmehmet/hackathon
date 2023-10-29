import 'package:hive/hive.dart';

part 'story.g.dart';

@HiveType(typeId: 0)
class Story extends HiveObject {
  @HiveField(0)
  final int storyID;

  @HiveField(1)
  final String storyTitle;

  @HiveField(2)
  final String storyContent;

  @HiveField(3)
  final String storyImage;

  @HiveField(4)
  bool isFavorite;

  Story({
    required this.storyID,
    required this.storyTitle,
    required this.storyContent,
    required this.storyImage,
    this.isFavorite = false,
  });
}
