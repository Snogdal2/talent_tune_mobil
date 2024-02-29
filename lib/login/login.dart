import 'package:flutter/material.dart';
import '../company/page_Container.dart';
import '../shared_state.dart';
import '../user/user.dart';
import '../util/pair.dart';
import '../util/show_snackbar.dart';

Form _loginForm(BuildContext context, Map<String, String>? userInfo) {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  if (userInfo != null) {
    usernameController.text = userInfo['username'] ?? '';
    passwordController.text = userInfo['password'] ?? '';
  }

  return Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: usernameController,
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          controller: passwordController,
        ),
        const SizedBox(height: 16.0),
        standardizedButton('Log ind', () async {
          Pair<bool, Pair<String, int>> result = await bearerTokenFromUserLogin(
            usernameController.text,
            passwordController.text,
          );
          if (result.first) {
            SharedState.setBearerToken(result.second.first);
            SharedState.setUserId(result.second.second);
            SecureSharedState.setUsername(usernameController.text);
            SecureSharedState.setPassword(passwordController.text);
            usernameController.text = '';
            passwordController.text = '';

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => pageContainer(const User())));
          } else {
            showSnackbar(context, 'Brugernavn eller adgangskode er forkert.');
          }
        }),
      ],
    ),
  );
}

class Login extends StatelessWidget {
  const Login();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: SecureSharedState.readAll(),
      builder: (
          BuildContext context,
          AsyncSnapshot<Map<String, String>> snapshot,
          ) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Henter gemt login...');
          default:
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  pageTitle('LOGIN'),
                  const SizedBox(height: 32.0),
                  _loginForm(context, snapshot.data),
                ],
              ),
            );
        }
      },
    );
  }
}
