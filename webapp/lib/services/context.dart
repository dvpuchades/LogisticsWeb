import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapp/models/user.dart';
import 'package:webapp/utils/data.dart';

import '../constants.dart';

Future<bool> getNewContext() async {
  try {
    print('running get new context');
    DateTime startTime = DateTime.now();
    String route = 'api/context/new';
    final response =
        await get(Uri.http(Backend.direction, route), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': User.getInstance().token
    });
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      Data.newFromJson(body);
      Data.getInstance().lastUpdate = startTime;
      return true;
    } else {
      print(response.statusCode);
      return Future.delayed(const Duration(seconds: 7), getNewContext);
    }
  } catch (e) {
    return Future.delayed(const Duration(seconds: 7), getNewContext);
  }
}

void updateContext() async {
  try {
    DateTime updateTime = DateTime.now();
    print('TRYING updateTime ' + updateTime.toString());
    String route = 'api/context/update/' +
        Data.getInstance().lastUpdate.millisecondsSinceEpoch.toString();
    final response =
        await get(Uri.http(Backend.direction, route), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': User.getInstance().token
    });
    if (response.statusCode == 200) {
      Data.getInstance().lastUpdate = updateTime;
      final body = json.decode(response.body);
      print('response body:');
      print(body);
      Data.getInstance().updateFromJson(body);
    } else {
      print(response.statusCode);
      getNewContext();
    }
  } catch (e) {
    print('exception in update context');
    print(e);
    getNewContext();
  }
}
