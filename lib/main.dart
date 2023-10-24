import 'package:flutter/material.dart';
import 'package:hackathon/pages/stories_page.dart';
import 'package:hackathon/routes.dart';
import 'package:hackathon/widgets/bottom_nav.dart';

void main() {
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
          child: Text("yapay zeka sayfası"),
        ),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text("Favoriler"),
        ),
        body: const Center(
          child: Text("favoriler sayfası"),
        ),
      ),
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
