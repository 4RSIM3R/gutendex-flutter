import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/components/card/book_card.dart';
import 'package:next_starter/presentation/layouts/book/bloc/book_layout_bloc.dart';
import 'package:next_starter/presentation/layouts/book/bloc/book_layout_state.dart';

class BookLayout extends StatefulWidget {
  const BookLayout({super.key});

  @override
  State<BookLayout> createState() => _BookLayoutState();
}

class _BookLayoutState extends State<BookLayout> {
  final bloc = locator<BookLayoutBloc>();

  @override
  void initState() {
    super.initState();
    bloc.all();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => bloc),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<BookLayoutBloc, BookLayoutState>(
            builder: (context, state) {
              if (state is BookLayoutSuccessState) {
                return Column(
                  children: state.books.map((e) => BookCard(model: e)).toList(),
                );
              } else if (state is BookLayoutFailureState) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
            },
          ),
        ),
      ),
    );
  }
}
