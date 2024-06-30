import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:next_starter/common/storage/shared_pref_storage.dart';
import 'package:next_starter/data/datasources/session/session_source.dart';

class MockSharedPrefStorageInterface extends Mock implements SharedPrefStorageInterface {}

void main() {
  late MockSharedPrefStorageInterface mockSharedPrefStorage;
  late SessionSource sessionSource;

  setUp(() {
    mockSharedPrefStorage = MockSharedPrefStorageInterface();
    sessionSource = SessionSource(shared: mockSharedPrefStorage);
  });

  group('SessionSource', () {
    test('get token should return stored token', () async {
      const testToken = 'testToken';

      when(() => mockSharedPrefStorage.get(SessionSource.key)).thenAnswer((_) async => 'testToken');

      final token = await sessionSource.token;

      expect(token, testToken);
      verify(() => mockSharedPrefStorage.get(SessionSource.key)).called(1);
    });

    test('setToken should store the token', () async {
      const testToken = 'testToken';

      when(() => mockSharedPrefStorage.store(SessionSource.key, any())).thenAnswer((_) async => {});

      await sessionSource.setToken(testToken);

      verify(() => mockSharedPrefStorage.store(SessionSource.key, testToken)).called(1);
    });

    test('deleteToken should remove the token', () async {
      when(() => mockSharedPrefStorage.remove(SessionSource.key)).thenAnswer((_) async => {});

      await sessionSource.deleteToken();

      verify(() => mockSharedPrefStorage.remove(SessionSource.key)).called(1);
    });

    test('hasSession should return true if token exists', () async {
      when(() => mockSharedPrefStorage.hasData(SessionSource.key)).thenAnswer((_) async => true);

      final hasSession = await sessionSource.hasSession;

      expect(hasSession, true);
      verify(() => mockSharedPrefStorage.hasData(SessionSource.key)).called(1);
    });

    test('hasSession should return false if token does not exist', () async {
      when(() => mockSharedPrefStorage.hasData(SessionSource.key)).thenAnswer((_) async => false);

      final hasSession = await sessionSource.hasSession;

      expect(hasSession, false);
      verify(() => mockSharedPrefStorage.hasData(SessionSource.key)).called(1);
    });
  });
}
