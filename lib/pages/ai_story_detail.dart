import 'package:flutter/material.dart';
import 'package:hackathon/service/ai_story_service.dart';


class AiStoryDetailPage extends StatefulWidget {
  final String subject;
  final String character;
  const AiStoryDetailPage({super.key, required this.subject, required this.character});

  @override
  State<AiStoryDetailPage> createState() => _AiStoryDetailPageState();
}

class _AiStoryDetailPageState extends State<AiStoryDetailPage> {
  String generatedStoryUI = "";

  Future<void> generateStory() async {
    final subject = widget.subject;
    final character = widget.character;

    final story = "$subject ile ilgili $character'in ana karakter olduğu 100 kelimelik bir masal anlat";

    final generatedStory= await AIStoryService.generateStory(story);

    setState(() {
      generatedStoryUI = generatedStory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Hikaye Oluşturucu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: generateStory,
              child: const Text("Hikaye Oluştur"),
            ),
            const SizedBox(height: 16),
            const Text(
              "Oluşturulan Hikaye:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  generatedStoryUI,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}