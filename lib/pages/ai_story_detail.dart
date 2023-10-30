import 'package:flutter/material.dart';

class AiStoryDetailPage extends StatefulWidget {
  final String subject;
  final String character;
  const AiStoryDetailPage({super.key, required this.subject, required this.character});

  @override
  State<AiStoryDetailPage> createState() => _AiStoryDetailPageState();
}

class _AiStoryDetailPageState extends State<AiStoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("${widget.subject} ${widget.character}"),);
  }
}
