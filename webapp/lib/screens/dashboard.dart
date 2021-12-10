import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:webapp/widgets/floating_layout.dart';
import 'package:webapp/widgets/side_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          const Expanded(child: SideBar()),
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  FlutterMap(
                      options: MapOptions(
                        center: LatLng(39.47256311597271, -0.37568144612336224),
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
                      ]),
                  const FloatingLayout(),
                ],
              ))
        ],
      ),
    ));
  }
}
