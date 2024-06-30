import 'package:bloc/bloc.dart';
import 'package:next_starter/data/datasources/local_datasources/book_local/book_local.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/presentation/pages/book/detail/bloc/book_detail_state.dart';

class BookDetailBloc extends Cubit<BookDetailState> {
  BookDetailBloc(this.local) : super(BookDetailInitialState());

  final BookLocal local;

  Future<void> like(BookModel model) async {
    emit(BookDetailLoadingState());

    try {
      await local.like(model);
      emit(BookDetailSuccessState());
    } catch (e) {
      emit(BookDetailFailureState(message: e.toString()));
    }
  }

  Future<void> dislike(BookModel model) async {
    emit(BookDetailLoadingState());

    try {
      await local.dislike(model);
      emit(BookDetailSuccessState());
    } catch (e) {
      emit(BookDetailFailureState(message: e.toString()));
    }
  }
}
