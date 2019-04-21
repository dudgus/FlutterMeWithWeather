import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/blocs/weather_bloc.dart';
import 'package:flutter_weather/widgets/forecast/forecast_list.dart';
import 'package:flutter_weather/widgets/gradient_container.dart';
import 'package:flutter_weather/widgets/weather_today/weather_last_updated.dart';
import 'package:flutter_weather/widgets/weather_today/weather_location.dart';
import 'package:flutter_weather/widgets/weather_today/weather_temp_combined.dart';

class WeatherPage extends StatefulWidget {
  final Location address;

  WeatherPage({this.address});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  MaterialColor _color;
  WeatherBloc _weatherBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc();
    _refreshCompleter = Completer<void>();
  }

  @override
  void dispose() {
    super.dispose();
    _weatherBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _weatherBloc.updateWeather(location: widget.address);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar(context) {
    return AppBar(
      title: Center(child: Text('Flutter Weather')),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
        stream: _weatherBloc.weather,
        builder: (context, AsyncSnapshot<Weather> weatherSnapshot) {
          if (weatherSnapshot.hasData) {
            Weather weather = weatherSnapshot.data;

            _updateThemeColor(weather.code);

            _refreshCompleter?.complete();
            _refreshCompleter = Completer();

            return GradientContainer(
              color: this._color,
              child: RefreshIndicator(
                onRefresh: () {
                  _weatherBloc.updateWeather();
                  return _refreshCompleter.future;
                },
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Center(
                        child: WeatherLocation(location: weather.city),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: WeatherLastUpdated(dateTime: weather.time),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Center(
                        child: WeatherTempCombined(
                          weather: weather,
                        ),
                      ),
                    ),
                    ForecastListWidget(weatherBloc: this._weatherBloc),
                  ],
                ),
              ),
            );
          } else if (weatherSnapshot.hasError) {
            return SnackBar(
              content: Text('Unknown Network Error Happens.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }
        });
  }

  void _updateThemeColor(int code) {
    if (code >= 200 && code <= 299) {
      this._color = Colors.deepPurple;
    } else if (code >= 300 && code <= 399) {
      _color = Colors.indigo;
    } else if (code >= 500 && code <= 599) {
      _color = Colors.indigo;
    } else if (code >= 600 && code <= 699) {
      _color = Colors.lightBlue;
    } else if (code >= 700 && code <= 799) {
      _color = Colors.blueGrey;
    } else if (code == 800) {
      _color = Colors.lightBlue;
    } else if (code == 801) {
      _color = Colors.lightBlue;
    } else if (code >= 802) {
      _color = Colors.blueGrey;
    }
  }
}
