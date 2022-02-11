import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapp/models/user.dart';
import 'package:webapp/utils/data.dart';

import '../constants.dart';

Future<bool> getNewContext() async {
  try {
    Data.getInstance().lastUpdate = DateTime.now();
    String route = 'api/context/new';
    final response =
        await get(Uri.http(Backend.direction, route), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': User.getInstance().token
    });
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      Data.newFromJson(body);
      return true;
    } else {
      return Future.delayed(const Duration(seconds: 7), getNewContext);
    }
  } catch (e) {
    return Future.delayed(const Duration(seconds: 7), getNewContext);
  }
}

void updateContext() async {
  try {
    DateTime updateTime = DateTime.now();
    String route =
        'api/context/update/' + Data.getInstance().lastUpdate.toString();
    final response =
        await get(Uri.http(Backend.direction, route), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': User.getInstance().token
    });
    if (response.statusCode == 200) {
      Data.getInstance().lastUpdate = updateTime;
      final body = json.decode(response.body);
      print(body);
      Data.getInstance().updateFromJson(body);
    } else {
      getNewContext();
    }
  } catch (e) {
    getNewContext();
  }
}
