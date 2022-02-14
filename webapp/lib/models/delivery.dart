import 'package:latlong2/latlong.dart';

class Delivery {
  late String id;
  late String address;
  late String city;
  late String? postcode;
  late String? customer;
  late String? phone;
  late String restaurant;

  late double? amount;

  late DateTime initTime;
  late DateTime? finishTime;
  late String? dealer;

  late LatLng? coordinates;

  Delivery(
      {required this.id,
      required this.address,
      required this.city,
      required this.restaurant,
      required this.initTime,
      this.postcode,
      this.customer,
      this.phone,
      this.dealer,
      this.amount = 0.0,
      this.finishTime,
      this.coordinates});

  Delivery.fromJson(var json) {
    id = json['_id'];
    address = json['address'];
    restaurant = json['restaurant'];
    city = json['city'];
    initTime = DateTime.parse(json['initTime']);
    amount = (json['amount'] ?? 0.0);
    customer = (json['customer'] ?? '');
    dealer = (json['dealer'] ?? '');
    phone = (json['phone'] ?? '');
    postcode = (json['postcode'] ?? '');
    if (json['longitude'] != null && json['latitude'] != null) {
      coordinates = LatLng(json['latitude'], json['longitude']);
    }
  }
}
