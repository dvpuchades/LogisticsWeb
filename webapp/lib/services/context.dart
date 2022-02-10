import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapp/models/user.dart';

import '../constants.dart';

Future<List> getNewContext() async {
  try {
    String route = 'api/context/new';
    final response =
        await get(Uri.http(Backend.direction, route), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': User.getInstance().token
    });
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print(body);
      return body;
    } else {
      return [];
    }
  } catch (e) {
    return [e.toString()];
  }
}
