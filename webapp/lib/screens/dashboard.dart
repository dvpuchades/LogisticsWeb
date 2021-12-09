import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            children: [
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Flexible(child: NewOrderButton()),
                  Flexible(child: ProfileButton())
                ],
              )), //new order and profile buttons
              const Spacer(flex: 5)
            ],
          ),
          flex: 4,
        )
      ],
    )));
  }
}
