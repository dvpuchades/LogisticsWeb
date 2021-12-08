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
                      child: ListView(shrinkWrap: true, children: const [
                    UserCard(name: 'Declan Simons', minutes: 39, deliveries: 4),
                    UserCard(
                        name: 'Melissa Rodrigues', minutes: 25, deliveries: 7),
                    UserCard(name: 'Jamie Almond', minutes: 21, deliveries: 5),
                    UserCard(
                        name: 'Laurence Knieve', minutes: 19, deliveries: 1),
                    UserCard(name: 'Paul Semper', minutes: 3, deliveries: 9),
                  ])),
                ]))),
        Expanded(
          child: Column(
            children: [
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                              height: 50,
                              width: 200,
                              child: Container(
                                color: ThemeColors.black,
                                child: TextButton(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.add,
                                          size: 30,
                                          color: ThemeColors.white,
                                        ),
                                        Text('New Order',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ThemeColors.white))
                                      ]),
                                  onPressed: () {
                                    //TODO
                                  },
                                ),
                              )))),
                  Flexible(
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 30),
                          child: SizedBox(
                              height: 50,
                              width: 200,
                              child: Container(color: ThemeColors.black))))
                ],
              )), //new order and profile buttons
              Spacer(flex: 5)
            ],
          ),
          flex: 4,
        )
      ],
    )));
  }
}
