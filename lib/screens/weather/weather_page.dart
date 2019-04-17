import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/blocs/weather_bloc.dart';
import 'package:flutter_weather/data/assets/assets.dart';
import 'package:flutter_weather/widgets/weather_today/weather_temp_combined.dart';
import 'package:flutter_weather/widgets/gradient_container.dart';
import 'package:flutter_weather/widgets/weather_today/weather_last_updated.dart';
import 'package:flutter_weather/widgets/weather_today/weather_location.dart';

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
                    StreamBuilder(
                        stream: _weatherBloc.forecast,
                        builder: (
                          context,
                          AsyncSnapshot<List<Weather>> forecastSnapshot,
                        ) {
                          if (forecastSnapshot.hasData) {
                            List<Widget> forecastWidgets = List();
                            forecastSnapshot.data.forEach((weather) {
                              forecastWidgets
                                  .add(_getWeatherIcon(weather.code));
                            });

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: forecastWidgets,
                            );
                          }
                          return CircularProgressIndicator();
                        }),
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

  Image _getWeatherIcon(int code) {
    String asset = Assets.iconCloud;
    if (code >= 200 && code <= 299) {
      asset = Assets.iconThunder;
    } else if (code >= 300 && code <= 399) {
      asset = Assets.iconCloudLittleRain;
    } else if (code >= 500 && code <= 599) {
      asset = Assets.iconRain;
    } else if (code >= 600 && code <= 699) {
      asset = Assets.iconSnow;
    } else if (code >= 700 && code <= 799) {
      asset = Assets.iconDust;
    } else if (code == 800) {
      asset = Assets.iconSun;
    } else if (code == 801) {
      asset = Assets.iconCloudSun;
    } else if (code >= 802) {
      asset = Assets.iconCloud;
    }
    return Image.asset(
      asset,
      width: 20,
      height: 20,
    );
  }
}
