import 'package:next_starter/data/models/book/book_model.dart';

abstract class BookLocal {
  Future<List<BookModel>> likes();
  Future<List<BookModel>> dislikes();
  Future<bool> like(BookModel model);
  Future<bool> dislike(BookModel model);
}
