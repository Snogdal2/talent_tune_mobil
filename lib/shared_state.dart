class SharedState {

  // should only be mutated in pages/login.dart
  static String? _bearerToken;

  static String bearerToken() {
    if (_bearerToken == null) {
      throw Exception('Token used before initialization');
    }
    return _bearerToken!;
  }

  static void setBearerToken(String token) {
    _bearerToken = token;
  }
}
