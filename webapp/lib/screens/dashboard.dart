import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/widgets/side_bar.dart';
import 'package:webapp/widgets/user_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
      children: [
        Expanded(child: const SideBar()),
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
