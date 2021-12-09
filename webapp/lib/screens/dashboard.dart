import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/widgets/buttons.dart';
import 'package:webapp/widgets/side_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
      children: [
        const Expanded(child: SideBar()),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Flexible(child: NewOrderButton()),
                  Flexible(child: ProfileButton())
                ],
              )),
              Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(top: 30, right: 30),
                      child: SizedBox(
                          height: 150,
                          width: 330,
                          child: Container(
                              color: ThemeColors.black,
                              child: Column(
                                children: [
                                  Flexible(
                                      child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(15),
                                          child: const Icon(
                                            Icons.shopping_bag_sharp,
                                            size: 30,
                                            color: ThemeColors.white,
                                          )),
                                      Container(
                                          margin: EdgeInsets.all(15),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: const [
                                                Text(
                                                  '35 Alverno Drive, Athlone',
                                                  style: NormalTextStyle(),
                                                ),
                                                Text('N34 WF82',
                                                    style: NormalTextStyle())
                                              ]))
                                    ],
                                  ))
                                ],
                              )))))
            ],
          ),
          flex: 4,
        )
      ],
    )));
  }
}
