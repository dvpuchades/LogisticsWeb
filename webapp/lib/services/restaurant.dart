import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapp/models/user.dart';

import '../constants.dart';

Future<String> createRestaurant(String name, String address) async {
  try {
    String route = 'api/restaurant';
    final response = await post(Uri.http(Backend.direction, route),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': User.getInstance().token
        },
        body: jsonEncode(<String, String>{"name": name, "address": address}));
    if (response.statusCode == 200) {
      return 'Restaurant created successfully';
    } else if (response.statusCode == 423) {
      return 'You need privileges for create a restaurant';
    } else {
      return 'Error creating restaurant';
    }
  } catch (e) {
    return e.toString();
  }
}

Future<List> getRestaurants() async {
  try {
    String route = 'api/restaurant';
    final response =
        await get(Uri.http(Backend.direction, route), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': User.getInstance().token
    });
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body;
    } else {
      return [];
    }
  } catch (e) {
    return [e.toString()];
  }
}
