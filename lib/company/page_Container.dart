import 'package:flutter/material.dart';

Scaffold pageContainer(Widget child) {
  // wrapping items in Scaffold prevents a yellow underline under text from occuring
  // see also: https://stackoverflow.com/questions/47114639/yellow-lines-under-text-widgets-in-flutter
  // and also allows the standard flutter snackbar to show correctly
  return Scaffold(
    body: DefaultTextStyle(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    ),
  );
}

