import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/getlocation/getlocation_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetLocation',
      home: GetLocationPage(),
    );
  }
}
