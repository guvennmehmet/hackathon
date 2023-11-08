import 'package:flutter/material.dart';

class StoryView extends StatelessWidget {
  final String storyImage;
  final String translatedTitle;
  final String translatedContent;
  final double titleFontSize;
  final double contentFontSize;

  const StoryView({super.key,
    required this.storyImage,
    required this.translatedTitle,
    required this.translatedContent,
    this.titleFontSize = 24,
    this.contentFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 8.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Image.asset(
                  'assets/images/$storyImage',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            translatedTitle,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              translatedContent,
              style: TextStyle(fontSize: contentFontSize),
            ),
          ),
        ],
      ),
    );
  }
}
