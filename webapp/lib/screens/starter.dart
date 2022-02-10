import 'package:flutter/material.dart';
import 'package:webapp/screens/dashboard.dart';
import 'package:webapp/services/context.dart';

class Starter extends StatelessWidget {
  const Starter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getNewContext(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Dashboard();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
