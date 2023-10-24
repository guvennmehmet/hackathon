import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int pageIndex;
  final Function(int) onPageChanged;

  const BottomNav({super.key, required this.pageIndex, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: onPageChanged,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Hikayeler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb),
          label: 'Yapay Zeka',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoriler',
        ),
      ],
    );
  }
}