import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/widgets/buttons.dart';
import 'package:webapp/widgets/delivery_card.dart';
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
              flex: 4,
              child: Container(
                  color: ThemeColors.white,
                  child: Column(children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Flexible(child: NewOrderButton()),
                        Flexible(child: ProfileButton())
                      ],
                    )),
                    Expanded(
                        flex: 6,
                        child: ListView(
                          padding: const EdgeInsets.only(top: 30),
                          shrinkWrap: true,
                          children: const [
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
                        ))
                  ])))
        ],
      ),
    ));
  }
}
