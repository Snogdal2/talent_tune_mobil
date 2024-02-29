class SharedState {
  // should only be mutated in components/user_event_dropdown.dart
  static int? _chosenEventId;

  static int chosenEventId() {
    if (_chosenEventId == null) {
      throw Exception('Chosen event id used before initialization');
    }
    return _chosenEventId!;
  }

  static void setChosenEventId(int id) {
    _chosenEventId = id;
  }

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

  // should only be mutated in pages/login.dart
  static int? _userId;

  static int userId() {
    if (_userId == null) {
      throw Exception('User id used before initialization');
    }
    return _userId!;
  }

  static void setUserId(int id) {
    _userId = id;
  }
}
