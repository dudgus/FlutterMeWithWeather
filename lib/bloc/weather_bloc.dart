import 'dart:async';

import 'package:flutter_weather/data/location/location.dart';
import 'package:flutter_weather/data/location/location_model.dart';
import 'package:flutter_weather/data/weather/weather.dart';
import 'package:flutter_weather/data/weather/weather_model.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final _weather = PublishSubject<Weather>();
  final _forecast = PublishSubject<List<Weather>>();

  Observable<Weather> get weather => _weather.stream;
  Observable<List<Weather>> get forecast => _forecast.stream;

  void updateCurrentWeather() async {
    final location = await getLocation();
    var weather = await getWeather(location: location);
    var address = await getAddress(query: weather.name);
    weather.name = address.formatted;
    _weather.sink.add(weather);
  }

  void dispose() {
    _weather.close();
    _forecast.close();
  }
}
