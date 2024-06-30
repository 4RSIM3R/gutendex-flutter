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
    test('add() should add a book to storage', () async {
      final book = BookModel(id: 1, title: 'Test Book');
      when(() => mockGetStorage.read('BOOKS')).thenReturn([]);
      when(() => mockGetStorage.writeIfNull('BOOKS', any())).thenAnswer((_) async => true);

      final result = await bookLocal.add(book);

      expect(result, true);
      verify(() => mockGetStorage.read('BOOKS')).called(1);
      verify(() => mockGetStorage.writeIfNull('BOOKS', [book.toJson()])).called(1);
    });

    test('all() should return a list of books from storage', () async {
      final bookJson = {'id': 1, 'title': 'Test Book'};
      when(() => mockGetStorage.read('BOOKS')).thenReturn([bookJson]);

      final result = await bookLocal.all();

      expect(result, isA<List<BookModel>>());
      expect(result.length, 1);
      expect(result.first.title, 'Test Book');
      verify(() => mockGetStorage.read('BOOKS')).called(1);
    });

    test('all() should return an empty list if no books in storage', () async {
      when(() => mockGetStorage.read('BOOKS')).thenReturn(null);

      final result = await bookLocal.all();

      expect(result, isEmpty);
      verify(() => mockGetStorage.read('BOOKS')).called(1);
    });
  });
}
