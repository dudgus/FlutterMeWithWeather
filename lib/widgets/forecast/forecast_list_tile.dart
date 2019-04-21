import 'package:flutter/material.dart';
import 'package:flutter_weather/blocs/weather_bloc.dart';
import 'package:flutter_weather/widgets/weather_util.dart';

class ForecastListTile extends StatelessWidget {
  final Weather weather;

  ForecastListTile({this.weather});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(
                  _getDayOfMonth(weather.time),
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                WeatherUtil.getWeatherIcon(
                    code: weather.code, width: 50.0, height: 50.0),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text(
                  WeatherUtil.formatTemperature(weather.temp),
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDayOfMonth(DateTime time) {
    return '${time.month} / ${time.day}';
  }
}
