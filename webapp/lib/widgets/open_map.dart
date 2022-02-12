import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:webapp/utils/location.dart';

class OpenMap extends StatefulWidget {
  const OpenMap({Key? key}) : super(key: key);

  @override
  _OpenMapState createState() => _OpenMapState();
}

class _OpenMapState extends State<OpenMap> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
        future: MyLocation.getLatLng(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FlutterMap(
              options: MapOptions(
                center: snapshot.data,
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  minZoom: 1,
                  maxZoom: 18,
                  backgroundColor: Colors.black,
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
