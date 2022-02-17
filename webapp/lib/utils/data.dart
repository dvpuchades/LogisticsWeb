import 'dart:collection';

import 'package:latlong2/latlong.dart';
import 'package:webapp/models/delivery.dart';
import 'package:webapp/models/restaurant.dart';

class Data {
  static Data _instance = Data._internal();
  List users = [];
  Map deliveries = HashMap();
  List notifications = [];
  Map restaurants = HashMap();
  DateTime lastUpdate = DateTime(1970);

  Data._internal() {
    users = [];
    deliveries = HashMap();
    notifications = [];
    restaurants = HashMap();
    lastUpdate = DateTime(1970);
  }

  static Data getInstance() {
    return _instance;
  }

  static void newFromJson(Map<String, dynamic> json) {
    _instance = Data._newFromJson(json);
  }

  Data._newFromJson(Map<String, dynamic> json) {
    users = json['users'];
    notifications = json['notifications'];
    print('executing newFromJson');
    for (var element in json['deliveries']) {
      LatLng? coordinates;
      if (element['latitude'] != null && element['longitude'] != null) {
        coordinates = LatLng(element['latitude'], element['longitude']);
      }
      Delivery delivery = Delivery(
          id: element['_id'],
          address: element['address'],
          city: element['city'],
          restaurant: element['restaurant'],
          initTime: DateTime.parse(element['initTime']),
          amount: (element['amount'] ?? ''),
          customer: (element['customer'] ?? ''),
          postcode: (element['postcode'] ?? ''),
          phone: (element['phone'] ?? ''),
          dealer: (element['dealer'] ?? ''),
          coordinates: coordinates);
      deliveries.addAll({delivery.id: delivery});
    }

    for (var restaurant in json['restaurants']) {
      var model = Restaurant(
          restaurant['_id'], restaurant['name'], restaurant['address']);
      restaurants.addAll({model.id: model});
    }
    print(restaurants);
  }

  void updateFromJson(Map<String, dynamic> json) {
    print(json);
    for (var element in json['restaurant']) {
      sortElement(element);
    }
    for (var element in json['brand']) {
      sortElement(element);
    }
  }

  void sortElement(element) {
    if (element['type'] == 'delivery') {
      if (element['operation'] != 'remove') {
        Delivery delivery = Delivery.fromJson(element['content']);
        deliveries.addAll({delivery.id: delivery});
        return;
      } else {
        deliveries.remove(element['content']['_id']);
        return;
      }
    }
    if (element['type'] == 'user') {}
    if (element['type'] == 'location') {}
    if (element['type'] == 'restaurant') {}
    if (element['type'] == 'notification') {}
  }

  static Map getDeliveries() {
    return _instance.deliveries;
  }

  static Map getRestaurants() {
    return _instance.restaurants;
  }
}
