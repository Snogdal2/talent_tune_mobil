import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureSharedState {
  static const _storage = FlutterSecureStorage();

  static Future setEmail(String email) async =>
      await _storage.write(key: 'email', value: email);

  static Future setPassword(String password) async =>
      await _storage.write(key: 'password', value: password);

  static Future<Map<String, String>> readAll() async =>
      await _storage.readAll();

  static Future clear() async => await _storage.deleteAll();
}
