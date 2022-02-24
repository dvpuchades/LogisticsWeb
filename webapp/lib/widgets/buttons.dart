import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/screens/new_restaurant_screen.dart';
import 'package:webapp/services/active.dart';
import 'package:webapp/utils/data.dart';
import 'package:webapp/utils/log_data.dart';
import 'package:webapp/models/user.dart';
import 'package:webapp/screens/login_screen.dart';
import 'package:webapp/screens/new_delivery_screen.dart';

class NewOrderButton extends StatelessWidget {
  const NewOrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: SizedBox(
            height: 50,
            width: 200,
            child: Container(
              color: ThemeColors.black,
              child: TextButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        size: 30,
                        color: ThemeColors.white,
                      ),
                      Text('New Order',
                          style:
                              TextStyle(fontSize: 20, color: ThemeColors.white))
                    ]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewDelivery()),
                  );
                },
              ),
            )));
  }
}

class ProfileButton extends StatefulWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  _ProfileButtonState createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  bool _active = Data.getUsers().containsKey(User.getInstance().email);

  String isActive(active) {
    if (active) {
      return 'Stop delivering';
    }
    return 'Start to delivery';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30, left: 20, right: 30),
        child: SizedBox(
          height: 50,
          width: 200,
          child: Container(
            alignment: Alignment.center,
            color: ThemeColors.black,
            child: DropdownButton(
              dropdownColor: ThemeColors.black,
              icon: const Icon(
                Icons.person,
                size: 30,
                color: ThemeColors.white,
              ),
              value: 'profile',
              style: const TextStyle(fontSize: 20, color: ThemeColors.white),
              items: [
                DropdownMenuItem(
                    child: Text(' ' + User.getInstance().name,
                        style: const TextStyle(
                            fontSize: 20, color: ThemeColors.white)),
                    value: 'profile'),
                const DropdownMenuItem(child: Text('Edit'), value: 'edit'),
                DropdownMenuItem(
                    child: Text(isActive(_active)), value: 'active'),
                const DropdownMenuItem(
                    child: Text('Create Restaurant'),
                    value: 'create restaurant'),
                const DropdownMenuItem(child: Text('Logout'), value: 'logout'),
              ],
              onChanged: (value) {
                if (value == 'edit') {
                  //TODO
                } else if (value == 'active') {
                  setActive(!_active);
                  setState(() {
                    _active = !_active;
                  });
                } else if (value == 'create restaurant') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewRestaurantScreen()),
                  );
                } else if (value == 'logout') {
                  LogData.removeFromStore();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                }
              },
            ),
          ),
        ));
  }
}
