import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_carbon/commons/commons.dart';

const _accessTokenKey = 'access_token';
const _isAlreadyOnBoardKey = 'is_already_on_board';

class PrefHelper {
  static final PrefHelper _prefHelper = PrefHelper._();
  late FlutterSecureStorage _secureStorage;

  factory PrefHelper() => _prefHelper;

  PrefHelper._() {
    _secureStorage = const FlutterSecureStorage();
  }

  Future<String?> getAccessToken() => _secureStorage.read(key: _accessTokenKey);

  void setAccessToken(String value) => _secureSaveValue(_accessTokenKey, value);

  Future<bool?> isAlreadyOnBoard() async {
    final value = await _secureStorage.read(key: _isAlreadyOnBoardKey);
    return value?.toBool();
  }

  void setAlreadyOnBoard({bool value = false}) {
    _secureSaveValue(_isAlreadyOnBoardKey, value);
  }

  Future<void> removeAllPref() async {
    await _secureStorage.deleteAll();
  }

  Future<void> removeUserSession() async {
    await _secureStorage.delete(key: _accessTokenKey);
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
