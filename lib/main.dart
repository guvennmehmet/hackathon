import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hackathon/models/story.dart';
import 'package:hackathon/pages/favorites_page.dart';
import 'package:hackathon/pages/stories_page.dart';
import 'package:hackathon/routes.dart';
import 'package:hackathon/widgets/bottom_nav.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StoryAdapter());
  await Hive.openBox<Story>('favoriteStories');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _pageIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const StoriesPage(),
      Scaffold(
        appBar: AppBar(
          title: const Text("Yapay Zeka"),
        ),
        body: const Center(
          child: Text("Yapay Zeka sayfası"),
        ),
      ),
      FavoritesPage(),
    ];
  }

  void _onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      initialRoute: '/',
      home: Scaffold(
        body: _pages[_pageIndex],
        bottomNavigationBar: BottomNav(pageIndex: _pageIndex, onPageChanged: _onPageChanged),
      ),
    );
  }
}
