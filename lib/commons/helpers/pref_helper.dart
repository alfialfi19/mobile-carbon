import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _accessTokenKey = 'access_token';

class PrefHelper {
  static final PrefHelper _prefHelper = PrefHelper._();
  late FlutterSecureStorage _secureStorage;

  factory PrefHelper() => _prefHelper;

  PrefHelper._() {
    _secureStorage = const FlutterSecureStorage();
  }

  Future<String?> getAccessToken() => _secureStorage.read(key: _accessTokenKey);

  void setAccessToken(String value) => _secureSaveValue(_accessTokenKey, value);

  Future<void> removeAllPref() async {
    await _secureStorage.deleteAll();
  }

  Future<void> _secureSaveValue<T>(String key, T value) async {
    if (value == null) {
      await _secureStorage.delete(key: key);
    } else {
      if (!(value is String ||
          value is bool ||
          value is int ||
          value is double)) {
        throw ArgumentError('only receive string, bool, int, double');
      }

      final parsedValue = value.toString();

      await _secureStorage.write(key: key, value: parsedValue);
    }
  }
}
