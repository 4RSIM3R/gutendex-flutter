import 'package:bloc/bloc.dart';
import 'package:next_starter/data/datasources/local_datasources/book_local/book_local.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/presentation/pages/book/detail/bloc/book_detail_state.dart';

class BookDetailBloc extends Cubit<BookDetailState> {
  BookDetailBloc(this.local) : super(BookDetailInitialState());

  final BookLocal local;

  Future<void> add(BookModel model) async {
    emit(BookDetailLoadingState());

    try {
      await local.add(model);
      emit(BookDetailSuccessState());
    } catch (e) {
      emit(BookDetailFailureState(message: e.toString()));
    }
  }
}
