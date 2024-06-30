import 'package:get_storage/get_storage.dart';
import 'package:next_starter/data/datasources/local_datasources/book_local/book_local.dart';
import 'package:next_starter/data/models/book/book_model.dart';

class BookLocalImpl implements BookLocal {
  final GetStorage box;

  BookLocalImpl({required this.box});

  @override
  Future<bool> like(BookModel model) async {
    var books = ((box.read('BOOK_LIKES') as List?) ?? [])..add(model.toJson());
    box.writeIfNull('BOOK_LIKES', books);
    return true;
  }

  @override
  Future<List<BookModel>> likes() async {
    return ((box.read('BOOK_LIKES') as List?) ?? []).map((e) => BookModel.fromJson(e)).toList();
  }

  @override
  Future<bool> dislike(BookModel model) async {
    var books = ((box.read('BOOK_DISLIKES') as List?) ?? [])..add(model.toJson());
    box.writeIfNull('BOOK_DISLIKES', books);
    return true;
  }

  @override
  Future<List<BookModel>> dislikes() async {
    return ((box.read('BOOK_DISLIKES') as List?) ?? []).map((e) => BookModel.fromJson(e)).toList();
  }
}
