import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:talent_tune_mobil/model/login_model.dart';

import '../shared_state.dart';

Future<logininfo> GetUserProfile() async {
  final token = SharedState.bearerToken();
  final profileResponse = await http.get(
    Uri.parse('http://localhost:3001/profile'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (profileResponse.statusCode == 200) {
    // If the profile request was successful,
    // then parse the profile JSON.
    return logininfo
        .fromJson(jsonDecode(profileResponse.body) as Map<String, dynamic>);
  } else {
    // If the profile request failed,
    // then throw an exception.
    throw Exception('Failed to get user profile.');
  }
}
