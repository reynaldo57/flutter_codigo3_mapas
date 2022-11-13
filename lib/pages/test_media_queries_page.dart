

import 'package:flutter/material.dart';
import 'package:flutter_codigo3_maps/pages/access_gps_pages.dart';
import 'package:flutter_codigo3_maps/utils/responsive.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class TestMediaQueryPage extends StatelessWidget {
  const TestMediaQueryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    //
    // print(_width);
    // print(_height);

    final ResponsiveUI responsive = ResponsiveUI.of(context);

    Orientation _orientation = MediaQuery.of(context).orientation;
    print(_orientation);


    if(kIsWeb){
      print("Se esta ejecutando en web");
    }else {
      print("Esta en otra plataforma");
      if(Platform.isAndroid){
        print("Android");
      }else if(Platform.isIOS){
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.deepPurpleAccent,
            height: responsive.hp(60),
            //width: _width * 0.8,
            alignment: Alignment.center,
            child: Text(
              "Hola",
              style: TextStyle(
                fontSize: ResponsiveUI.of(context).hp(10),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AccessPage()));
          }, child: Text("Go")),
        ],
      ),
    );
  }
}
