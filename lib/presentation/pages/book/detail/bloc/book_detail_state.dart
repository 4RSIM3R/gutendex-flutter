abstract class BookDetailState {}

class BookDetailInitialState extends BookDetailState {}

class BookDetailLoadingState extends BookDetailState {}

class BookDetailFailureState extends BookDetailState {
  final String message;

  BookDetailFailureState({required this.message});
}

class BookDetailSuccessState extends BookDetailState {}
