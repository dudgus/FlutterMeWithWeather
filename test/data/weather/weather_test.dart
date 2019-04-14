
import 'package:flutter_weather/data/location/location_model.dart';
import 'package:flutter_weather/data/weather/weather_model.dart';
import 'package:flutter_weather/data/weather/weather.dart';
import 'package:test/test.dart';

void main() {
  test('get weather from where I am', () async {
    final Weather weather = await getWeather();
    expect(weather, isNotNull);
    expect(weather.summary.length > 0, true);
  });

  test('get weather from 매탄동', () async {
    // 37.2593553, 127.0547372 - 매탄동
    final location = LatLng(37.2593553, 127.0547372);
    final Weather weather = await getWeather(location: location);
    expect(weather, isNotNull);
    expect(weather.summary.length > 0, true);
  });

  test('get forecasts from 매탄동', () async {
    // 37.2593553, 127.0547372 - 매탄동
    final location = LatLng(37.2593553, 127.0547372);
    final List<Weather> weathers = await getForecasts(location: location);
    expect(weathers, isNotNull);
    expect(weathers.length > 0, true);
    expect(weathers[0].summary.length > 0, true);
  });
}
