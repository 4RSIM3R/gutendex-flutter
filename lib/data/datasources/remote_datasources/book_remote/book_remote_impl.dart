import 'package:next_starter/common/base/base_dio_remote_source.dart';
import 'package:next_starter/common/utils/api_path.dart';
import 'package:next_starter/data/datasources/remote_datasources/book_remote/book_remote.dart';
import 'package:next_starter/data/models/book/book_model.dart';

class BookRemoteImpl extends BaseDioRemoteSource implements BookRemote {
  BookRemoteImpl(super.dio, super.session);

  @override
  Future<PaginateBookModel> all({int? page, String? search}) {
    return networkRequest(
      request: (dio) => dio.get("books", queryParameters: {'page': page, 'search': search}),
      onResponse: (response) => PaginateBookModel.fromJson(response),
    );
  }

  @override
  Future<BookModel> detail({required int id}) {
    return networkRequest(
      request: (dio) => dio.get('${ApiPath.book}/$id'),
      onResponse: (response) => BookModel.fromJson(response),
    );
  }
}
