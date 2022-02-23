import 'package:latlong2/latlong.dart';

class Worker {
  late String name;
  late String email;
  late String? restaurant;
  late String? phone;

  late bool privilege;
  late LatLng? coordinates;

  Worker(this.name, this.email, this.restaurant, this.phone, this.coordinates);

  Worker.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    restaurant = json['restaurant'];
    phone = json['phone'];
    privilege = json['privilege'];
    if (json['latitude'] != null && json['longitude'] != null) {
      coordinates = LatLng(json['latitude'], json['longitude']);
    }
  }
}
