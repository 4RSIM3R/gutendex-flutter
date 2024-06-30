import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:next_starter/common/base/base_dio_remote_source.dart';
import 'package:next_starter/common/errors/api_exception.dart';
import 'package:next_starter/data/datasources/session/session_source.dart';

class MockSessionSource extends Mock implements SessionSource {}

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late MockSessionSource mockSessionSource;
  late BaseDioRemoteSource baseDioRemoteSource;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    mockSessionSource = MockSessionSource();
    baseDioRemoteSource = BaseDioRemoteSource(dio, mockSessionSource);
  });

  group('BaseDioRemoteSource', () {
    test('should return data on successful request', () async {
      const testData = 'test data';

      dioAdapter.onGet(
        'test',
        (request) => request.reply(200, testData),
      );

      final result = await baseDioRemoteSource.networkRequest<String>(
        request: (dio) => dio.get('test'),
        onResponse: (data) => data as String,
      );

      expect(result, testData);
    });

    test('should handle unauthorized request by deleting token', () async {
      dioAdapter.onGet(
        'test',
        (request) => request.reply(401, {}),
      );

      expect(
        () async => await baseDioRemoteSource.networkRequest<String>(
          request: (dio) => dio.get('test'),
          onResponse: (data) => data as String,
        ),
        throwsA(isA<ApiException>()),
      );

    
    });

    test('should throw ApiException on DioException', () async {
      dioAdapter.onGet(
        'test',
        (request) => request.throws(
          500,
          DioException(requestOptions: RequestOptions()),
        ),
      );

      expect(
        () async => await baseDioRemoteSource.networkRequest<String>(
          request: (dio) => dio.get('test'),
          onResponse: (data) => data as String,
        ),
        throwsA(isA<ApiException>()),
      );
    });

    test('should handle non-2xx status codes correctly', () async {
      dioAdapter.onGet(
        'test',
        (request) => request.reply(500, {}),
      );

      expect(
        () async => await baseDioRemoteSource.networkRequest<String>(
          request: (dio) => dio.get('test'),
          onResponse: (data) => data as String,
        ),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
