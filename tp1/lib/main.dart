import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:tp1/chat_page.dart';
import 'package:tp1/home_page.dart';
import 'package:tp1/profile_page.dart';
import 'package:tp1/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  final List<Widget> list = const [
    HomePage(),
    SearchPage(),
    ChatPage(),
    ProfilePage(),
  ];


  final List<String> titles = const ['Home', 'Search', 'Chat', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_page]),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: IndexedStack(
        index: _page,
        children: list,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _page, // garde l'icône sélectionnée synchronisée
        backgroundColor: Colors.blueAccent,
        onTap: (index) {
          setState(() {
            _page = index; // on change seulement la page affichée
          });
        },
        items: const [
          CurvedNavigationBarItem(child: Icon(Icons.home), label: 'Home'),
          CurvedNavigationBarItem(child: Icon(Icons.search), label: 'Search'),
          CurvedNavigationBarItem(child: Icon(Icons.message), label: 'Chat'),
          CurvedNavigationBarItem(child: Icon(Icons.perm_identity), label: 'Profile'),
        ],
      ),
    );
  }
}