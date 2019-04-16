import 'package:flutter/material.dart';
import 'package:flutter_weather/blocs/weather_bloc.dart';
import 'package:flutter_weather/widgets/temperature.dart';
import 'package:flutter_weather/widgets/weather_condition.dart';

import 'package:meta/meta.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  final Weather weather;

  CombinedWeatherTemperature({
    Key key,
    @required this.weather,
  })  : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: WeatherConditions(code: weather.code),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Temperature(
                temperature: weather.temp,
                high: weather.tempMax,
                low: weather.tempMin,
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            weather.desc,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
