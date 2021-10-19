import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:webapp/services/auth.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        title: 'fattorino',
        onLogin: loginUser,
        onSignup: loginUser,
        onSubmitAnimationCompleted: () {},
        onRecoverPassword: _recoverPassword);
  }
}
