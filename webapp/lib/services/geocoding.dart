import 'dart:convert';

import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';

const apiKey = '821da2c7488b43cbbd6095e0c1c9aeb4';
const direction = 'api.geoapify.com';

Future<LatLng?> getCoordinates(
    String address, String city, String postcode) async {
  String text = address + '%2C%20' + city + '%2C%20' + postcode;
  text = text.replaceAll(' ', '%20');
  try {
    final response = await get(Uri.parse(
        'https://api.geoapify.com/v1/geocode/search?text=$text&limit=1&format=json&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print(body);
      if (body['results'][0] == null) {
        return null;
      }
      return LatLng(body['results'][0]['lat'], body['results'][0]['lon']);
    } else {
      print('Something went wrong. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (e) {
    print('exception on get coordinates');
    print(e);
    return null;
  }
}
