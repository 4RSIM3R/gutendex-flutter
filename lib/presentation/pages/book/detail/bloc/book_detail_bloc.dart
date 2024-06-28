import 'package:bloc/bloc.dart';
import 'package:next_starter/presentation/pages/book/detail/bloc/book_detail_state.dart';

class BookDetailBloc extends Cubit<BookDetailState> {
  BookDetailBloc() : super(BookDetailInitialState());
}
