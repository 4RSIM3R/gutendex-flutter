import 'package:next_starter/common/base/base_repository.dart';
import 'package:next_starter/common/typedefs/typedefs.dart';
import 'package:next_starter/data/datasources/remote_datasources/book_remote/book_remote.dart';
import 'package:next_starter/data/models/book/book_model.dart';

class BookRepository extends BaseRepository {
  BookRepository(super.networkInfo, this.remote);

  final BookRemote remote;

  EitherResponse<List<BookModel>> all({int? page, String? search}) {
    return handleNetworkCall(
      call: remote.all(page: page, search: search),
      onSuccess: (r) => r,
    );
  }

  EitherResponse<BookModel> detail({required int id}) {
    return handleNetworkCall(
      call: remote.detail(id: id),
      onSuccess: (r) => r,
    );
  }
}
