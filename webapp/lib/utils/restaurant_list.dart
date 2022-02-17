import 'package:latlong2/latlong.dart';
import 'package:webapp/models/restaurant.dart';

class RestaurantList {
  static RestaurantList _instance = RestaurantList._internal();
  List all = [];
  String predilected = "";

  factory RestaurantList() {
    return _instance;
  }

  static RestaurantList getInstance() {
    return _instance;
  }

  RestaurantList._internal();

  RestaurantList.fromJson(List json) {
    for (var item in json) {
      all.add(Restaurant(
          item['_id'],
          item['name'],
          item['address'],
          item['city'],
          item['postcode'],
          LatLng(item['latitude'], item['longitude'])));
    }
    _instance = this;
  }
}
