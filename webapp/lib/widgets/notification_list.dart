import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webapp/utils/data.dart';
import 'cards.dart';

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
