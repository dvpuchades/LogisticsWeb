import 'package:flutter/material.dart';

import '../constants.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            UserCard(name: 'Melissa Rodrigues', minutes: 25, deliveries: 7),
            UserCard(name: 'Jamie Almond', minutes: 21, deliveries: 5),
            UserCard(name: 'Laurence Knieve', minutes: 19, deliveries: 1),
            UserCard(name: 'Paul Semper', minutes: 3, deliveries: 9),
          ])),
        ]));
  }
}

class UserCard extends StatefulWidget {
  const UserCard(
      {Key? key,
      required this.name,
      required this.minutes,
      required this.deliveries})
      : super(key: key);

  final String name;
  final int minutes;
  final int deliveries;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    String message =
        'left ${widget.minutes} minutes ago \ndelivered ${widget.deliveries} orders';
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: ListTile(
          leading: const Icon(Icons.directions_bike,
              color: ThemeColors.white, size: 40),
          title: Text(widget.name,
              style: const SpecialTextStyle(color: ThemeColors.white)),
          subtitle:
              Text(message, style: const TextStyle(color: ThemeColors.white)),
        ));
  }
}
