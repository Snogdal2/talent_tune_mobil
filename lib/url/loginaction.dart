import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:talent_tune_mobil/model/login_model.dart';

Future<logininfo> logincall(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:3001/auth/token'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return logininfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}