import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/presentation/layouts/book/book_;ayout.dart';
import 'package:next_starter/presentation/layouts/home/home_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const path = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _layouts = [const HomeLayout(), const BookLayout()];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gutendex'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.question_circle),
          )
        ],
      ),
      body: _layouts[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => _index = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
           BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Home',
            tooltip: 'Home',
            activeIcon: Icon(CupertinoIcons.heart_fill)
          ),
        ],
      ),
    );
  }
}
