import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo3_maps/pages/access_gps_pages.dart';
import 'package:flutter_codigo3_maps/pages/loading_page.dart';
import 'package:flutter_codigo3_maps/pages/home_page.dart';
import 'package:flutter_codigo3_maps/pages/test_media_queries_page.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestMediaQueryPage(),
    );
  }
}