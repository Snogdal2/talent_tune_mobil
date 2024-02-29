import 'dart:convert';
import '../util/pair.dart';
import 'url_helper.dart';


Future<Pair<bool, Pair<String, int>>> bearerTokenFromUserLogin(
    String username, String password) async {
  var url = uriHelper('/login');
  var response =
  await post(url, body: {'username': username, 'password': password});

  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  if (response.statusCode == 200) {
    String token = decodedResponse['Bearer'];

    Map<String, dynamic> payload = Jwt.parseJwt(token);

    return Pair(true, Pair(token, payload['userId']));
  }

  return const Pair(false, Pair('', 0));
}
