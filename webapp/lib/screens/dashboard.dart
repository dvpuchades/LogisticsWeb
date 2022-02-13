import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webapp/services/context.dart';
import 'package:webapp/widgets/buttons.dart';
import 'package:webapp/widgets/notification_list.dart';
import 'package:webapp/widgets/open_map.dart';
import 'package:webapp/widgets/side_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      updateContext();
    });
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          const Expanded(child: SideBar()),
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    child: const OpenMap(),
                    color: Colors.white,
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Flexible(child: NewOrderButton()),
                        Flexible(child: ProfileButton())
                      ],
                    )),
                    const Expanded(flex: 6, child: NotificationList())
                  ])
                ],
              ))
        ],
      ),
    ));
  }
}
