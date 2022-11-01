



import 'package:flutter/material.dart';
import 'package:flutter_codigo3_maps/pages/home_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGPSAndLocation(),
        builder: (context, snap){
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
  Future<String> checkGPSAndLocation() async{
    final permissionLocation = await Permission.location.isGranted;
    final gpsActive = await Geolocator.isLocationServiceEnabled();
    if(permissionLocation && gpsActive){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      return "";
    }else if(!permissionLocation){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      return "Es necesario el permiso del GPS";
    }else{
      return "Activar el GPS";
    }
  }
}
