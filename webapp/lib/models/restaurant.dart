import 'package:latlong2/latlong.dart';

class Restaurant {
  late String id;
  late String name;
  late String address;
  late String city;
  late String postcode;
  late LatLng coordinates;

  Restaurant(this.id, this.name, this.address, this.city, this.postcode,
      this.coordinates);

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        address = json['address'],
        city = json['city'],
        postcode = json['postcode'],
        coordinates = LatLng(json['latitude'], json['longitude']);
}
