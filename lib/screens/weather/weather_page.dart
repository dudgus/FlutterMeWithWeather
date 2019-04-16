import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/blocs/weather_bloc.dart';
import 'package:flutter_weather/widgets/combine_weather_temperature.dart';
import 'package:flutter_weather/widgets/gradient_container.dart';
import 'package:flutter_weather/widgets/last_updated.dart';
import 'package:flutter_weather/widgets/location.dart';

class WeatherPage extends StatefulWidget {

  final Address address;

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
    _weatherBloc.updateCurrentWeather(address: widget.address);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Flutter Weather'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
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
        builder: (context, AsyncSnapshot<Weather> snapshot) {
          if (snapshot.hasData) {
            Weather weather = snapshot.data;

            _updateThemeColor(weather.code);

            _refreshCompleter?.complete();
            _refreshCompleter = Completer();

            return GradientContainer(
              color: this._color,
              child: RefreshIndicator(
                onRefresh: () {
                  _weatherBloc.updateCurrentWeather();
                  return _refreshCompleter.future;
                },
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Center(
                        child: Location(location: weather.city),
                      ),
                    ),
                    Center(
                      child: LastUpdated(dateTime: weather.time),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: Center(
                        child: CombinedWeatherTemperature(
                          weather: weather,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return SnackBar(
              content: Text('Unknown Network Error Happens.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
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
