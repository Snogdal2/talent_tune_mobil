import 'package:flutter/material.dart';
import 'company/page_Container.dart';
import 'login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FEMU',
      home: Scaffold(
        body: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          child: pageContainer(const Login()),
        ),
      ),
    );
  }
}
