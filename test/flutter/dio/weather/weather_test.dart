import 'package:flutter_weather/data/location/model/location_model.dart';
import 'package:flutter_weather/data/weather/model/weather_model.dart';
import 'package:test/test.dart';
import 'package:dio/dio.dart';

void main() {

  // 37.2593553, 127.0547372 - 매탄동
  final location = LatLng(37.2593553, 127.0547372);

  group('get weather by lat & lng', () {
    Response response;

    setUpAll(() async {
      final uri = buildUri('/weather', location);
      response = await Dio().get(uri.toString());
    });

    test('check response', () {
      expect(response, isNotNull);
      expect(response.statusCode, equals(200));
    });

    test('check json serialized data', () {
      Weather weather = Weather.fromJson(response.data);
      expect(weather, isNotNull);
      expect(weather.summary.length > 0, true);
    });
  });

  group('get forecast by lat & lng', () {
    Response response;

    setUpAll(() async {
      final uri = buildUri('/forecast', location);
      response = await Dio().get(uri.toString());
    });

    test('check response', () {
      expect(response, isNotNull);
      expect(response.statusCode, equals(200));
    });

    test('check json serialized data', () {
      var forecasts = (response.data['list'] as List)
          .map((model) => Weather.fromJson(model))
          .toList();
      expect(forecasts, isNotNull);
      expect(forecasts[0], isNotNull);
      expect(forecasts[0].summary, isNotNull);
      expect(forecasts[0].summary.length > 0, true);
    });
  });

}

Uri buildUri(String apiEndPoint, LatLng location) {
  final String apiBaseUrl = 'api.openweathermap.org';
  final String apiPath = '/data/2.5';
  final String apiKey = '7eb5b98821e6ef05e4c37c8efba059b5';

  return Uri(
      scheme: 'https',
      host: apiBaseUrl,
      path: '$apiPath$apiEndPoint',
      queryParameters: {
        'appid': apiKey,
        'lat': '${location.lat}',
        'lon': '${location.lng}',
      });
}
