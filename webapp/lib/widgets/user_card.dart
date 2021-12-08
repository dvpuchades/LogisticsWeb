import 'package:flutter/material.dart';

import '../constants.dart';

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
          leading: const Icon(Icons.person, color: ThemeColors.white, size: 40),
          title: Text(widget.name,
              style: const SpecialTextStyle(color: ThemeColors.white)),
          subtitle:
              Text(message, style: const TextStyle(color: ThemeColors.white)),
        ));
  }
}
