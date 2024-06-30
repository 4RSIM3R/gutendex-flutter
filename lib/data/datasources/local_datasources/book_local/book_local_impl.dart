import 'package:get_storage/get_storage.dart';
import 'package:next_starter/data/datasources/local_datasources/book_local/book_local.dart';
import 'package:next_starter/data/models/book/book_model.dart';

class BookLocalImpl implements BookLocal {
  final GetStorage box;

  BookLocalImpl({required this.box});

  @override
  Future<bool> add(BookModel model) async {
    var books = ((box.read('BOOKS') as List?) ?? [])..add(model.toJson());
    box.writeIfNull('BOOKS', books);
    return true;
  }

  @override
  Future<List<BookModel>> all() async {
    return ((box.read('BOOKS') as List?) ?? []).map((e) => BookModel.fromJson(e)).toList();
  }
}
