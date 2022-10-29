
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo3_maps/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {

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
        onMapCreated: (GoogleMapController controller){
          controller.setMapStyle(jsonEncode(mapStyle));
        },
      ),
    );
  }
}
