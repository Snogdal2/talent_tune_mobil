import 'package:flutter/material.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'hey',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
