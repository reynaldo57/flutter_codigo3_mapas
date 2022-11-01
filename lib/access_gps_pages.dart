

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo3_maps/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  _AccessPageState createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Es necesario activar el GPS"),
            SizedBox(
              height: 10,
            ),
            CupertinoButton(
              color: Colors.black87,
                child: Text("Activar GPS"),
                onPressed: ()async{
                PermissionStatus status = await Permission.location.request();
                accessLocation(status);
                }
                )
          ],
        ),
      ),
    );
  }
  void accessLocation(PermissionStatus status){
    switch(status){
      case PermissionStatus.granted:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.limited:
      case PermissionStatus.restricted:
        openAppSettings();
        break;
    }

  }
}
