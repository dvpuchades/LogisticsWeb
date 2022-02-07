import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
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

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = User.getInstance().name;
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
                    child: Text(' ' + name,
                        style: const TextStyle(
                            fontSize: 20, color: ThemeColors.white)),
                    value: 'profile'),
                const DropdownMenuItem(child: Text('Edit'), value: 'edit'),
                const DropdownMenuItem(child: Text('Logout'), value: 'logout'),
              ],
              onChanged: (value) {
                if (value == 'edit') {
                  //TODO
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
