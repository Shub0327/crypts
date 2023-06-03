import 'package:crypts/currencies.dart';
import 'package:crypts/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  // currency();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  Home(),
    );
  }
}
