
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo3_maps/utils/map_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<MarkerId, Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> _points = [];


  @override
  void initState(){
    //TODO: implement initState
    super.initState();
    initCurrentPosition();
  }

  Future<CameraPosition>initCurrentPosition() async{
    Position currentPosition = await Geolocator.getCurrentPosition();
    CameraPosition _initialCameraPosition = CameraPosition(target: LatLng(
        currentPosition.latitude, currentPosition.longitude,),
      zoom: 14,
    );
    return _initialCameraPosition;

  }

  getCurrentPositionAndController(GoogleMapController controller) async{

    final iconTruck = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/truck.png');
    final markerTruckId = MarkerId(_markers.length.toString());



    _polylines.add(
      Polyline(
        polylineId: PolylineId("Ruta Repartidor"),
        points: _points,
        color: Colors.deepPurpleAccent,
        width: 7,
      )
    );

    Geolocator.getPositionStream().listen((Position position){
      LatLng pos = LatLng(position.latitude, position.longitude);
      CameraUpdate cameraUpdate = CameraUpdate.newLatLng(pos);
      _points.add(pos);
      controller.animateCamera(cameraUpdate);
      final markerTruck = Marker(
          markerId: markerTruckId,
          icon: iconTruck,
          position: pos
      );
      _markers[markerTruckId] = markerTruck;
      setState(() {

      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: initCurrentPosition(),
          builder: (context, snap){
            if(snap.hasData){
              CameraPosition cam = snap.data as CameraPosition;
              return GoogleMap(
                initialCameraPosition: cam,
                //myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                markers: _markers.values.toSet(),
                polylines: _polylines,
                onMapCreated: (GoogleMapController controller){
                  controller.setMapStyle(jsonEncode(mapStyle));
                  getCurrentPositionAndController(controller);
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
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },
        )
          // children: [
          //
          //   // Column(
          //   //   mainAxisAlignment: MainAxisAlignment.end,
          //   //   children: [
          //   //     CupertinoButton(
          //   //         color: Colors.black87,
          //   //         child: Text("Registrar Incidencia"),
          //   //         onPressed: () async{
          //   //           Position currentPosition = await Geolocator.getCurrentPosition();
          //   //           print(currentPosition);
          //   //         })
          //   //   ],
          //   // )
          //   // Column(
          //   //   mainAxisAlignment: MainAxisAlignment.end,
          //   //   children: [
          //   //     SingleChildScrollView(
          //   //       scrollDirection: Axis.horizontal,
          //   //       child: Row(
          //   //         children: [
          //   //           Container(
          //   //             height: 200,
          //   //             width: 200,
          //   //             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //   //             decoration: BoxDecoration(
          //   //               color: Colors.white,
          //   //               boxShadow: [
          //   //                 BoxShadow(
          //   //                     color: Colors.black54.withOpacity(0.24),
          //   //                     blurRadius: 12,
          //   //                     offset: Offset(0,4)
          //   //                 )
          //   //               ],
          //   //               borderRadius: BorderRadius.circular(24.0),
          //   //             ),
          //   //           ),
          //   //           Container(
          //   //             height: 200,
          //   //             width: 200,
          //   //             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //   //             decoration: BoxDecoration(
          //   //               color: Colors.white,
          //   //               boxShadow: [
          //   //                 BoxShadow(
          //   //                     color: Colors.black54.withOpacity(0.24),
          //   //                     blurRadius: 12,
          //   //                     offset: Offset(0,4)
          //   //                 )
          //   //               ],
          //   //               borderRadius: BorderRadius.circular(24.0),
          //   //             ),
          //   //           )
          //   //         ],
          //   //       ),
          //   //     )
          //   //   ],
          //   // )
          // ],
        ),
      );
  }
}
