import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapp/models/user.dart';

import '../constants.dart';

Future<String> createDelivery(String address, String city, String postcode,
    String phone, String customer, double amount) async {
  try {
    String route = 'api/delivery';
    final response = await post(Uri.http(Backend.direction, route),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': User.getInstance().token
        },
        body: jsonEncode(<String, dynamic>{
          "address": address,
          "city": city,
          "postcode": postcode,
          "amount": amount,
          "customer": customer,
          "phone": phone
        }));
    if (response.statusCode == 200) {
      return '';
    } else {
      return 'Error processing the delivery';
    }
  } catch (e) {
    return e.toString();
  }
}
