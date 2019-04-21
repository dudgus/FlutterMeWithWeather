import 'dart:async';

import 'package:flutter_weather/data/location/location.dart' as data;
import 'package:flutter_weather/data/location/location_model.dart' as data;
import 'package:flutter_weather/data/location/location_model.dart';
import 'package:flutter_weather/data/weather/weather.dart' as data;
import 'package:flutter_weather/data/weather/weather_model.dart' as data;
import 'package:rxdart/rxdart.dart';

class Weather {
  final int code;
  final String main;
  final String desc;
  final double temp;
  final double tempMax;
  final double tempMin;
  final double pressure;
  final double humidity;
  final double windSpeed;
  final double windDeg;
  final double clouds;
  final DateTime time;
  String city;

  Weather(
      this.code,
      this.main,
      this.desc,
      this.temp,
      this.tempMax,
      this.tempMin,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.windDeg,
      this.clouds,
      this.time,
      this.city);

  String toString() {
    return '$city ($code) : $desc $temp $time';
  }
}

class Location {
  final LatLng latLng;
  final String city;

  Location({this.latLng, this.city});
}

class WeatherBloc {
  final _weather = PublishSubject<Weather>();
  final _forecast = PublishSubject<List<Weather>>();

  Observable<Weather> get weather => _weather.stream;

  Observable<List<Weather>> get forecast => _forecast.stream;

  void updateWeather({Location location}) async {
    LatLng latLng = await _getLatLng(location);
    Weather weather = _convert(await data.getWeather(latLng: latLng));
    weather.city = await _getKorFormattedCityName(latLng);

    _weather.sink.add(weather);

    _updateForecasts(Location(latLng: latLng, city: weather.city));
  }

  void _updateForecasts(Location location) async {
    List<data.Weather> weathers =
        await data.getForecasts(latLng: location.latLng);

    List<Weather> forecast = List();
    weathers
        .where((weather) => weather.timeText.contains('12:00:00'))
        .forEach((weather) {
      weather.name = location.city;
      forecast.add(_convert(weather));
    });

    print('forecast: ${forecast.length}');

    _forecast.sink.add(forecast);
  }

  Future<LatLng> _getLatLng(Location location) async {
    return (location == null) ? await data.getLatLng() : location.latLng;
  }

  Weather _convert(data.Weather weather, {Location given}) {
    final int code = weather.summary[0].id;
    final String main = weather.summary[0].main;
    final String desc = _convertDesc(code);
    final double temp = weather.main.temp;
    final double tempMax = weather.main.tempMax;
    final double tempMin = weather.main.tempMin;
    final double pressure = weather.main.pressure;
    final double humidity = weather.main.humidity;
    final double windSpeed = weather.wind.speed;
    final double windDeg = weather.wind.deg;
    final double clouds = weather.cloud.all;
    final String city = weather.name;
    final DateTime time =
        DateTime.fromMillisecondsSinceEpoch(weather.time * 1000, isUtc: true);

    print('updated : $time');

    return Weather(code, main, desc, temp, tempMax, tempMin, pressure, humidity,
        windSpeed, windDeg, clouds, time, city);
  }

  Future<String> _getKorFormattedCityName(LatLng latLng) async {
    data.Address address = (await data.getAddresses(location: latLng))[0];
    return _pickLastThreeNames(address);
  }

  String _pickLastThreeNames(data.Address address) {
    List<String> formatted = List();
    address.components.forEach((comp) {
      print(comp.longName + ' ' + comp.types.toString());
      if (_notContainsWrongAddressCode(comp.types))
        formatted.add(comp.longName);
    });
    return formatted.reversed.join(' ');
  }

  bool _notContainsWrongAddressCode(List<String> types) {
    return !(types.contains('postal_code') ||
        types.contains('premise') ||
        types.contains('country') ||
        types.contains('administrative_area_level_1') ||
        types.contains('administrative_area_level_4') ||
        types.contains('sublocality_level_4'));
  }

  String _convertDesc(int code) {
    String desc = '';
    if (200 == code) return '가벼운 비를 동반한 천둥구름';
    if (201 == code) return '비를 동반한 천둥구름';
    if (202 == code) return '폭우를 동반한 천둥구름';
    if (210 == code) return '약한 천둥구름';
    if (211 == code) return '천둥구름';
    if (212 == code) return '강한 천둥구름';
    if (221 == code) return '불규칙적 천둥구름';
    if (230 == code) return '약한 연무를 동반한 천둥구름';
    if (231 == code) return '연무를 동반한 천둥구름';
    if (232 == code) return '강한 안개비를 동반한 천둥구름';
    if (300 == code) return '가벼운 안개비';
    if (301 == code) return '안개비';
    if (302 == code) return '강한 안개비';
    if (310 == code) return '가벼운 적은비';
    if (311 == code) return '적은비';
    if (312 == code) return '강한 적은비';
    if (313 == code) return '소나기와 안개비';
    if (314 == code) return '강한 소나기와 안개비';
    if (321 == code) return '소나기';
    if (500 == code) return '악한 비';
    if (501 == code) return '중간 비';
    if (502 == code) return '강한 비';
    if (503 == code) return '매우 강한 비';
    if (504 == code) return '극심한 비';
    if (511 == code) return '우박';
    if (520 == code) return '약한 소나기 비';
    if (521 == code) return '소나기 비';
    if (522 == code) return '강한 소나기 비';
    if (531 == code) return '불규칙적 소나기 비';
    if (600 == code) return '가벼운 눈';
    if (601 == code) return '눈';
    if (602 == code) return '강한 눈';
    if (611 == code) return '진눈깨비';
    if (612 == code) return '소나기 진눈깨비';
    if (615 == code) return '약한 비와 눈';
    if (616 == code) return '비와 눈';
    if (620 == code) return '약한 소나기 눈';
    if (621 == code) return '소나기 눈';
    if (622 == code) return '강한 소나기 눈';
    if (701 == code) return '박무';
    if (711 == code) return '연기';
    if (721 == code) return '연무';
    if (731 == code) return '모래 먼지';
    if (741 == code) return '안개';
    if (751 == code) return '모래';
    if (761 == code) return '먼지';
    if (762 == code) return '화산재';
    if (771 == code) return '돌풍';
    if (781 == code) return '토네이도';
    if (800 == code) return '구름 한 점 없는 맑은 하늘';
    if (801 == code) return '약간의 구름이 낀 하늘';
    if (802 == code) return '드문드문 구름이 낀 하늘';
    if (803 == code) return '구름이 거의 없는 하늘';
    if (804 == code) return '구름으로 뒤덮인 흐린 하늘';
    if (900 == code) return '토네이도';
    if (901 == code) return '태풍';
    if (902 == code) return '허리케인';
    if (903 == code) return '한랭';
    if (904 == code) return '고온';
    if (905 == code) return '바람부는';
    if (906 == code) return '우박';
    if (951 == code) return '바람이 거의 없는';
    if (952 == code) return '약한 바람';
    if (953 == code) return '부드러운 바람';
    if (954 == code) return '중간 세기 바람';
    if (955 == code) return '신선한 바람';
    if (956 == code) return '센 바람';
    if (957 == code) return '돌풍에 가까운 센 바람';
    if (958 == code) return '돌풍';
    if (959 == code) return '심각한 돌풍';
    if (960 == code) return '폭풍';
    if (961 == code) return '강한 폭풍';
    if (962 == code) return '허리케인';
    return desc;
  }

  void dispose() {
    _weather.close();
    _forecast.close();
  }
}
