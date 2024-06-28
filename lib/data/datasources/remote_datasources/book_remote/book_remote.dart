import 'package:next_starter/data/models/book/book_model.dart';

abstract class BookRemote {
  Future<PaginateBookModel> all({int? page, String? search});
  Future<BookModel> detail({required int id});
}