import 'package:flutter/material.dart';
import '../secure_share_state.dart';
import '../shared_state.dart';
import '../url/loginaction.dart';
import '../user/user.dart';
import '../util/show_snackbar.dart';

Form _loginForm(BuildContext context, Map<String, String>? userInfo) {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  if (userInfo != null) {
    emailController.text = userInfo['username'] ?? '';
    passwordController.text = userInfo['password'] ?? '';
  }

  return Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: emailController,
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          controller: passwordController,
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () async {

            var result = await logincall(emailController.text, passwordController.text);
            if (result != null) {
              SharedState.setBearerToken(result.token);
              SecureSharedState.setUsername(emailController.text);
              SecureSharedState.setPassword(passwordController.text);
              emailController.text = '';
              passwordController.text = '';

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const User()));
            } else {
              showSnackbar(context, 'Brugernavn eller adgangskode er forkert.');
            }
          },
          child: const Text('Enabled'),
        )
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
