import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/location_bloc.dart';
import 'package:flutter_weather/data/location/location_model.dart';
import 'package:flutter_weather/screen/weather/weather_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final _locationBloc;

  MyApp() : _locationBloc = LocationBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterWeather',
      home: WeatherPage(location: LatLng(37.2593553, 127.0547372)),
    );
  }
}
