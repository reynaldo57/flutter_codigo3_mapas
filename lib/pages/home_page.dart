
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
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              markers: _markers.values.toSet(),
              onMapCreated: (GoogleMapController controller){
                controller.setMapStyle(jsonEncode(mapStyle));
              },
              onTap: (LatLng position) async{
                final icon =
                await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/policeman.png');
                final markerId = MarkerId(_markers.length.toString());
                final marker = Marker(
                    markerId: markerId,
                    position: position,
                    //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                    //icon: BitmapDescriptor.defaultMarkerWithHue(240),
                    icon: icon,
                    rotation: -10,
                    anchor: Offset(0.5, 1),
                    draggable: true,
                    onDragEnd: (LatLng newPosition){
                      print(newPosition);
                    },
                    onTap: (){
                      print("llamar modal");
                    }
                );
                _markers[markerId] = marker;

                setState(() {

                });
              },
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 200,
            //             width: 200,
            //             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               boxShadow: [
            //                 BoxShadow(
            //                     color: Colors.black54.withOpacity(0.24),
            //                     blurRadius: 12,
            //                     offset: Offset(0,4)
            //                 )
            //               ],
            //               borderRadius: BorderRadius.circular(24.0),
            //             ),
            //           ),
            //           Container(
            //             height: 200,
            //             width: 200,
            //             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               boxShadow: [
            //                 BoxShadow(
            //                     color: Colors.black54.withOpacity(0.24),
            //                     blurRadius: 12,
            //                     offset: Offset(0,4)
            //                 )
            //               ],
            //               borderRadius: BorderRadius.circular(24.0),
            //             ),
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      )
    );
  }
}
