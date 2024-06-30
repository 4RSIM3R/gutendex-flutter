import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:next_starter/data/datasources/local_datasources/book_local/book_local_impl.dart';
import 'package:next_starter/data/models/book/book_model.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late MockGetStorage mockGetStorage;
  late BookLocalImpl bookLocal;

  setUp(() {
    mockGetStorage = MockGetStorage();
    bookLocal = BookLocalImpl(box: mockGetStorage);
  });

  group('BookLocalImpl', () {
    const likeKey = 'BOOK_LIKES';
    test('add() should add a book to storage', () async {
      final book = BookModel(id: 1, title: 'Test Book');
      when(() => mockGetStorage.read(likeKey)).thenReturn([]);
      when(() => mockGetStorage.writeIfNull(likeKey, any())).thenAnswer((_) async => true);

      final result = await bookLocal.like(book);

      expect(result, true);
      verify(() => mockGetStorage.read(likeKey)).called(1);
      verify(() => mockGetStorage.writeIfNull(likeKey, [book.toJson()])).called(1);
    });

    test('all() should return a list of books from storage', () async {
      final bookJson = {'id': 1, 'title': 'Test Book'};
      when(() => mockGetStorage.read(likeKey)).thenReturn([bookJson]);

      final result = await bookLocal.likes();

      expect(result, isA<List<BookModel>>());
      expect(result.length, 1);
      expect(result.first.title, 'Test Book');
      verify(() => mockGetStorage.read(likeKey)).called(1);
    });

    test('all() should return an empty list if no books in storage', () async {
      when(() => mockGetStorage.read(likeKey)).thenReturn(null);

      final result = await bookLocal.likes();

      expect(result, isEmpty);
      verify(() => mockGetStorage.read(likeKey)).called(1);
    });
  });
}
