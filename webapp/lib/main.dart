import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/screens/dashboard.dart';
import 'package:webapp/screens/login_screen.dart';
import 'package:webapp/services/auth.dart';

import 'models/log_data.dart';

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
      home: _decideHomeScreen(),
    );
  }
}

FutureBuilder _decideHomeScreen() {
  return FutureBuilder(
    future: LogData.getFromStore(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data['email'].isEmpty) {
          return const LoginScreen();
        } else {
          var data = snapshot.data;
          return FutureBuilder(
              future: loginUser(data['email'], data['password']),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == '') {
                    return const Dashboard();
                  } else {
                    return const LoginScreen();
                  }
                } else {
                  return const LoginScreen();
                }
              });
        }
      }
      return Container();
    },
  );
}
