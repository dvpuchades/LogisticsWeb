import 'package:http/http.dart';
import 'package:webapp/models/user.dart';
import 'dart:convert';
import '../constants.dart';

Future<List> getBrandSuggestions(String pattern) async {
  try {
    String route = 'api/brand/search/$pattern';
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

Future<String> createBrand(String name) async {
  try {
    String route = 'api/brand/';
    final response = await post(Uri.http(Backend.direction, route),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': User.getInstance().token
        },
        body: jsonEncode(<String, String>{"name": name}));
    if (response.statusCode == 200) {
      return 'Brand created successfully';
    } else if (response.statusCode == 400) {
      return 'Brand already exist';
    } else {
      return 'Error creating brand';
    }
  } catch (e) {
    return e.toString();
  }
}

Future<String> requestBrandAccess(String name) async {
  try {
    String route = 'api/brand/request';
    final response = await post(Uri.http(Backend.direction, route),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': User.getInstance().token
        },
        body: jsonEncode(<String, String>{"name": name}));
    if (response.statusCode == 200) {
      return 'Request created successfully';
    } else if (response.statusCode == 404) {
      return 'Brand not found';
    } else {
      return 'Internal error';
    }
  } catch (e) {
    return e.toString();
  }
}
