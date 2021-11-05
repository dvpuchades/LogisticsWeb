import 'package:http/http.dart';
import 'dart:convert';

String direction = 'localhost:2400';

Future<List> getBrandSuggestions(String pattern) async {
  try {
    String route = 'api/brand/search/$pattern';
    final response = await post(Uri.http(direction, route),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
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
