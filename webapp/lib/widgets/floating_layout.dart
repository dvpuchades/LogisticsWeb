import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webapp/utils/data.dart';
import 'buttons.dart';
import 'cards.dart';

class FloatingLayout extends StatelessWidget {
  const FloatingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Flexible(child: NewOrderButton()),
          Flexible(child: ProfileButton())
        ],
      )),
      const Expanded(flex: 6, child: NotificationList())
    ]));
  }
}

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {});
    });
    return SizedBox(
        width: 400,
        child: ListView(
            padding: const EdgeInsets.only(top: 30),
            shrinkWrap: true,
            children: Data.getDeliveries()
                .entries
                .map((e) => DeliveryCard(delivery: e.value))
                .toList()));
  }
}
