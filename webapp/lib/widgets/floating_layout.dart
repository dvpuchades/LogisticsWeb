import 'package:flutter/material.dart';

import '../constants.dart';
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

class NotificationList extends StatelessWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        child: ListView(
          padding: const EdgeInsets.only(top: 30),
          shrinkWrap: true,
          children: const [
            NotificationCard(
                title: "New Request",
                body: "John Smith wants to access to your restaurant."),
            DeliveryCard(
                address: '35 Alverno Drive',
                postcode: 'N34 WF87',
                city: 'Athlone',
                state: 'In kitchen',
                amount: 15.05,
                minutes: 2),
            DeliveryCard(
                address: '12 Willow Drive',
                postcode: 'N34 WF87',
                city: 'Athlone',
                state: 'In kitchen',
                amount: 15.05,
                minutes: 10),
            DeliveryCard(
                address: '3 Heather Street',
                postcode: 'N34 WF87',
                city: 'Athlone',
                state: 'Declan Simons',
                amount: 19.25,
                minutes: 12),
            DeliveryCard(
                address: 'Croi Oige 20',
                postcode: 'N34 WF87',
                city: 'Athlone',
                state: 'Melissa Rodrigues',
                amount: 15.05,
                minutes: 23),
            DeliveryCard(
                address: 'Golden Island Center',
                postcode: 'N34 WF87',
                city: 'Athlone',
                state: 'Jamie Almond',
                amount: 54.90,
                minutes: 34),
          ],
        ));
  }
}
