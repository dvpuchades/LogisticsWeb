import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
      children: [
        Expanded(
            child: Column(
          children: [
            const DrawerHeader(
                child: Text('Fattorino', style: TitleTextStyle())),
            Card(
                child: Column(
              children: [
                const Text('Declan Smith'),
                Row(
                  children: const [
                    Flexible(child: Text('29 minutes out'), flex: 3),
                    Spacer(),
                    Flexible(child: Text('2 deliveries to go'), flex: 3)
                  ],
                )
              ],
            ))
          ],
        )),
        Expanded(
          child: Container(color: Colors.white),
          flex: 5,
        )
      ],
    )));
  }
}
