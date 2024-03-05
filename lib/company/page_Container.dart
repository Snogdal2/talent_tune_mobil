import 'package:flutter/material.dart';

Scaffold pageContainer(Widget child) {
  // wrapping items in Scaffold prevents a yellow underline under text from occuring
  // see also: https://stackoverflow.com/questions/47114639/yellow-lines-under-text-widgets-in-flutter
  // and also allows the standard flutter snackbar to show correctly
  return Scaffold(
    body: DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.black
      ),
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    ),
  );
}
