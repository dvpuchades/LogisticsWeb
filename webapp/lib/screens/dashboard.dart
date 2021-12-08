import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/widgets/user_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
      children: [
        Expanded(
            child: Container(
                color: ThemeColors.black,
                child: Column(children: [
                  SizedBox(
                      child: Container(
                        color: ThemeColors.green,
                        child: const Text('Fattorino', style: TitleTextStyle()),
                        alignment: Alignment.center,
                      ),
                      height: 100),
                  Expanded(
                      child: ListView(shrinkWrap: true, children: [
                    const UserCard(
                        name: 'Declan Simons', minutes: 39, deliveries: 4),
                    const UserCard(
                        name: 'Melissa Rodrigues', minutes: 25, deliveries: 7),
                    const UserCard(
                        name: 'Jamie Almond', minutes: 21, deliveries: 5),
                    const UserCard(
                        name: 'Laurence Knieve', minutes: 19, deliveries: 1),
                    const UserCard(
                        name: 'Paul Semper', minutes: 3, deliveries: 9),
                  ])),
                ]))),
        Expanded(
          child: Container(color: Colors.white),
          flex: 4,
        )
      ],
    )));
  }
}
