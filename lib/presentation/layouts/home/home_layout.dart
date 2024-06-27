import 'package:flutter/material.dart';
import 'package:next_starter/common/extensions/extensions.dart';
import 'package:next_starter/data/repositories/book_repository.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/components/components.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final _repo = locator<BookRepository>();

  final _form = fb.group({'search': []});

  @override
  void initState() {
    super.initState();
    _repo.all();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ReactiveFormBuilder(
            form: () => _form,
            builder: (context, form, child) {
              return  Column(
                children: [
                  const TextInput(
                    formControlName: 'search',
                    hint: 'Search Book...',
                  ),
                  const Column(
                    children: [
                      
                    ],
                  ).expand()
                ],
              );
            }),
      ),
    );
  }
}
