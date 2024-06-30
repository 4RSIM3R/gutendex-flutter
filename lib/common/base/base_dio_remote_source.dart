import 'package:dio/dio.dart';

import '../../data/datasources/session/session_source.dart';
import '../errors/api_exception.dart';
import '../extensions/api_extension.dart';
import '../logging/logger.dart';

/// [BaseDioRemoteSource] for handling network requests for dio client
class BaseDioRemoteSource {
  BaseDioRemoteSource(this._dio, this._session);

  final Dio _dio;
  final SessionSource _session;

  /// [T] is return type from network request
  ///
  /// [request] callback returns [Response] and accepts [Dio] instance
  ///
  /// [onResponse] callback returns [T] and accepts [dynamic] data from [Response]
  ///
  /// throws [ApiException]

  Future<T> networkRequest<T>({
    required Future<Response> Function(Dio dio) request,
    required T Function(dynamic data) onResponse,
    bool isAuth = false,
    bool isPaginate = false,
    bool isMessage = false,
    bool isResponseAll = false,
  }) async {
    try {
      if (isAuth) {
        final token = await _session.hasSession;
        if (token) {
          _dio.options.headers.addAll({"Authorization": "Bearer $token"});
        } else {
          _dio.options.headers.remove("Authorization");
        }
      } else {
        _dio.options.headers.remove("Authorization");
      }
      final response = await request(_dio);

      if (response.statusCode == 401) await _session.deleteToken();

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        return onResponse(response.data);
      } else {
        logger.e("Success with Error: ${response.statusCode}");
        throw const ApiException.serverException(message: 'UnExpected Error in status code!!!');
      }
    } on DioException catch (e) {
      ApiException err = e.toApiException;
      throw err;
    } catch (e) {
      logger.e(e);
      throw const ApiException.serverException(message: 'UnExpected Error Occurred in dio!!!');
    }
  }
}
