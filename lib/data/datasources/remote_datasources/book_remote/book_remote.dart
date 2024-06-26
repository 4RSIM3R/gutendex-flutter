import 'package:next_starter/data/models/book/book_model.dart';

abstract class BookRemote {
  Future<List<BookModel>> all({int? page, String? search});
  Future<BookModel> detail({required int id});
}