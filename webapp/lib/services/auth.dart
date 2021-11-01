import 'package:http/http.dart';
import 'package:webapp/models/user.dart';
import 'dart:convert';

String direction = 'localhost:2400';

Future<String> loginUser(String email, String password) async {
  try {
    const route = 'api/auth/login';
    final response = await post(Uri.http(direction, route),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body:
            jsonEncode(<String, String>{"email": email, "password": password}));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      User.fromJson(body);
      return '';
    } else if (response.statusCode == 404) {
      return 'User not found';
    } else if (response.statusCode == 403) {
      return 'Wrong password';
    } else {
      return 'Something gets wrong';
    }
  } catch (e) {
    return e.toString();
  }
}

Future<String> signupUser(String name, String email, String password) async {
  try {
    const route = 'api/auth/signup';
    final response = await post(Uri.http(direction, route),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "email": email,
          "password": password
        }));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      User.fromJson(body);
      return '';
    } else if (response.statusCode == 423) {
      return 'Email used before';
    } else {
      return 'Something gets wrong';
    }
  } catch (e) {
    return e.toString();
  }
}
