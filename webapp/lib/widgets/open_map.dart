import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/models/delivery.dart';
import 'package:webapp/utils/data.dart';
import 'package:webapp/utils/location.dart';

class OpenMap extends StatefulWidget {
  const OpenMap({Key? key}) : super(key: key);

  @override
  _OpenMapState createState() => _OpenMapState();
}

class _OpenMapState extends State<OpenMap> {
  List<Marker> _markers = [];
  Timer? _timer;

  List<Marker> getMarkers() {
    List<Marker> result = [];
    for (Delivery delivery in Data.getDeliveries().values) {
      if (delivery.coordinates != null) {
        result.add(Marker(
            point: delivery.coordinates!,
            builder: (context) => const Icon(Icons.fastfood,
                size: 30, color: ThemeColors.black)));
      }
    }
    return result;
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _markers = getMarkers();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _markers = getMarkers();
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
                MarkerLayerOptions(markers: _markers),
              ],
              children: [
                TileLayerWidget(
                    options: TileLayerOptions(
                  minZoom: 1,
                  maxZoom: 18,
                  backgroundColor: Colors.black,
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                )),
                MarkerLayerWidget(
                    options: MarkerLayerOptions(markers: _markers))
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
