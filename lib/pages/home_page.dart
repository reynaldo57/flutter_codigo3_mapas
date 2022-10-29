
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo3_maps/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<MarkerId, Marker> _markers = {};

  final _initialCameraPosition = CameraPosition(target: const LatLng(
      -12.1847695,
      -76.9988664
  ),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        scrollGesturesEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        markers: _markers.values.toSet(),
        onMapCreated: (GoogleMapController controller){
          controller.setMapStyle(jsonEncode(mapStyle));
        },
        onTap: (LatLng position){
          final markerId = MarkerId(_markers.length.toString());
          final marker = Marker(
              markerId: markerId,
              position: position,
          );
          _markers[markerId] = marker;

          setState(() {

          });
        },
      ),
    );
  }
}
