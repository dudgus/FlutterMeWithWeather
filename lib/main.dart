import 'package:flutter/material.dart';
import 'package:flutter_weather/data/location/location_model.dart';
import 'screens/weather/weather_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterWeather',
      home: WeatherPage(),
    );
  }
}
