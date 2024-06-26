import 'package:flutter/material.dart';
import 'package:next_starter/data/repositories/book_repository.dart';
import 'package:next_starter/injection.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final _repo = locator<BookRepository>();

  @override
  void initState() {
    super.initState();
    _repo.all();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
