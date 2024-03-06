import 'package:flutter/material.dart';
import 'register.dart';
import 'secure_share_state.dart';
import 'shared_state.dart';
import 'url/loginaction.dart';
import 'user/user.dart';
import 'util/show_snackbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // if (userInfo != null) {
    // emailController.text = userInfo['username'] ?? '';
    // passwordController.text = userInfo['password'] ?? '';
    // }
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.secondary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: emailController,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              style: const TextStyle(color: Colors.black),
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

                  Navigator.push(context, MaterialPageRoute(builder: (context) => const User()));
                } else {
                  showSnackbar(context, 'Brugernavn eller adgangskode er forkert.');
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: const Text('Register'),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
