import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fattorino',
      theme: ThemeData(
          primarySwatch: MaterialThemeColors.green,
          scaffoldBackgroundColor: MaterialThemeColors.green),
      home: const LoginScreen(),
    );
  }
}
