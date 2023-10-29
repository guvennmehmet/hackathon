import 'package:flutter/material.dart';

class BackToTopButton extends StatefulWidget {
  final ScrollController controller;

  const BackToTopButton({Key? key, required this.controller}) : super(key: key);

  @override
  _BackToTopButtonState createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.offset > 100
        ? FloatingActionButton(
      onPressed: () {
        widget.controller.animateTo(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.arrow_upward),
    )
        : const SizedBox();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }
}
