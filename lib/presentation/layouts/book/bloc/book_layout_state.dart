import 'package:next_starter/data/models/book/book_model.dart';

class BookLayoutState {}

class BookLayoutInitialState extends BookLayoutState {}

class BookLayoutLoadingState extends BookLayoutState {}

class BookLayoutFailureState extends BookLayoutState {
  final String message;

  BookLayoutFailureState({required this.message});
}

class BookLayoutSuccessState extends BookLayoutState {
  final List<BookModel> books;

  BookLayoutSuccessState({required this.books});
}
