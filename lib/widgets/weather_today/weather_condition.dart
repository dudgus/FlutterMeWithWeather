import 'package:flutter/material.dart';
import 'package:flutter_weather/widgets/weather_util.dart';
import 'package:meta/meta.dart';

class WeatherConditions extends StatelessWidget {
  final int code;

  WeatherConditions({Key key, @required this.code})
      : assert(code != null),
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      WeatherUtil.getWeatherIcon(code: code, width: 100.0, height: 100.0);
}
