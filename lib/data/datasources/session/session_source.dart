import '../../../common/storage/shared_pref_storage.dart';

class SessionSource {
  final SharedPrefStorageInterface shared;
  static const String key = 'token';

  SessionSource({
    required this.shared,
  });

  Future<String?> get token async {
    return await shared.get(key);
  }

  Future<void> setToken(String token) async {
    await shared.store(key, token);
  }

  Future<void> deleteToken() async {
    await shared.remove(key);
  }

  Future<bool> get hasSession async => await shared.hasData(key);
}
