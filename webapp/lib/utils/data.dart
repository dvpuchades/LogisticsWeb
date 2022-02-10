import 'dart:collection';

import 'package:webapp/models/delivery.dart';
import 'package:webapp/models/restaurant.dart';

class Data {
  static Data _instance = Data._internal();
  List users = [];
  Map deliveries = HashMap();
  List notifications = [];
  List restaurants = [];

  Data._internal() {
    users = [];
    deliveries = HashMap();
    notifications = [];
    restaurants = [];
  }

  static Data getInstance() {
    return _instance;
  }

  static void newFromJson(Map<String, dynamic> json) {
    _instance = Data._newFromJson(json);
  }

  Data._newFromJson(Map<String, dynamic> json) {
    users = json['users'];
    deliveries = json['deliveries'];
    notifications = json['notifications'];

    restaurants = [];
    for (var restaurant in json['restaurants']) {
      var model = Restaurant(
          restaurant['_id'], restaurant['name'], restaurant['address']);
      restaurants.add(model);
    }
  }

  void updateFromJson(Map<String, dynamic> json) {}

  void sortElement(element) {
    if (element['operation'] == 'new') {
      if (element['type'] == 'delivery') {}
      if (element['type'] == 'delivery') {}
    }

    if (element['operation'] == 'update') {}

    if (element['operation'] == 'delete') {}

    if (element['operation'] == 'activate') {}

    if (element['operation'] == 'deactivate') {}

    //restart
    if (element['type'] == 'delivery') {
      if (element['operation'] != 'remove') {
        Delivery delivery = Delivery(
            id: element['content']['_id'],
            address: element['content']['address'],
            city: element['content']['city'],
            restaurant: element['content']['restaurant'],
            initTime: DateTime.parse(element['content']['initTime']),
            amount: (element['content']['amount'] ?? ''),
            customer: (element['content']['customer'] ?? ''),
            postcode: (element['content']['postcode'] ?? ''),
            phone: (element['content']['phone'] ?? ''),
            dealer: (element['content']['dealer'] ?? ''));
        deliveries.addAll({delivery.id: delivery});
      } else {
        deliveries.remove(element['content']['_id']);
      }
    }
    if (element['type'] == 'user') {}
    if (element['type'] == 'location') {}
    if (element['type'] == 'restaurant') {}
    if (element['type'] == 'notification') {}
  }
}
