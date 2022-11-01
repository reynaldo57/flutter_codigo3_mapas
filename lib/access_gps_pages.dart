
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo3_maps/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessPage extends StatefulWidget {

  @override
  _AccessPageState createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> with WidgetsBindingObserver{

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void dispose(){
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    //TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      if(await Permission.location.isGranted){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
    }
  }



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
