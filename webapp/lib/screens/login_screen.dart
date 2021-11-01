import 'package:flutter/material.dart';
import 'package:webapp/widgets/login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoginCard());
  }
}
