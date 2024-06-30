import 'package:bloc/bloc.dart';
import 'package:next_starter/data/datasources/local_datasources/book_local/book_local.dart';
import 'package:next_starter/presentation/layouts/book/bloc/book_layout_state.dart';

class BookLayoutBloc extends Cubit<BookLayoutState> {
  BookLayoutBloc(this.local) : super(BookLayoutInitialState());

  final BookLocal local;

  Future<void> all() async {
    emit(BookLayoutLoadingState());

    try {
      final result = await local.all();
      emit(BookLayoutSuccessState(books: result));
    } catch (e) {
      emit(BookLayoutFailureState(message: e.toString()));
    }
  }
}
