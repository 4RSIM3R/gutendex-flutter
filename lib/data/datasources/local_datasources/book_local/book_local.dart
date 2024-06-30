import 'package:next_starter/data/models/book/book_model.dart';

abstract class BookLocal {
  Future<List<BookModel>> all();
  Future<bool> add(BookModel model);
}
