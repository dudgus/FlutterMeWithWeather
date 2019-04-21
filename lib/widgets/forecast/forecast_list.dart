
import 'package:flutter/material.dart';
import 'package:flutter_weather/blocs/weather_bloc.dart';
import 'package:flutter_weather/widgets/forecast/forecast_list_tile.dart';
import 'package:flutter_weather/widgets/weather_util.dart';

class ForecastListWidget extends StatelessWidget {
  final WeatherBloc weatherBloc;

  ForecastListWidget({this.weatherBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: weatherBloc.forecast,
        builder: (
            context,
            AsyncSnapshot<List<Weather>> forecastSnapshot,
            ) {
          if (forecastSnapshot.hasData) {
            List<Widget> forecastWidgets = List();
            forecastSnapshot.data.forEach((weather) {
              forecastWidgets
                  .add(ForecastListTile(weather: weather));
            });

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: forecastWidgets,
            );
          }
          return CircularProgressIndicator();
        });
  }
}
