import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapp/models/user.dart';

import '../constants.dart';

Future<bool> setActive(bool active) async {
  try {
    String route = 'api/user/active';
    final response = await put(Uri.http(Backend.direction, route),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': User.getInstance().token
        },
        body: jsonEncode(<String, dynamic>{'active': active}));
    if (response.statusCode == 200) {
      print('active entered');
      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  } catch (e) {
    print('exception in setActive');
    print(e);
    return false;
  }
}
