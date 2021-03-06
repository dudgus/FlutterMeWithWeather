import 'package:dio/dio.dart';
import 'package:flutter_weather/data/location/location.dart';
import 'package:flutter_weather/data/location/location_model.dart';
import 'package:flutter_weather/data/weather/weather_model.dart';

final String _apiBaseUrl = 'api.openweathermap.org';
final String _apiPath = '/data/2.5';
final String _apiKey = '7eb5b98821e6ef05e4c37c8efba059b5';
final String _weatherEndPoint = '/weather';
final String _forecastEndPoint = '/forecast';

Future<Weather> getWeather({LatLng latLng}) async {
  if (latLng == null) latLng = await getLatLng();

  final uri = _buildUri(_weatherEndPoint, latLng);
  Response response = await Dio().get(uri.toString());
  return (response.statusCode == 200) ? Weather.fromJson(response.data) : null;
}

Future<List<Weather>> getForecasts({LatLng latLng}) async {
  if (latLng == null) latLng = await getLatLng();

  final uri = _buildUri(_forecastEndPoint, latLng);
  Response response = await Dio().get(uri.toString());
  return (response.statusCode == 200)
      ? (response.data['list'] as List)
          .map((model) => Weather.fromJson(model))
          .toList()
      : null;
}

Uri _buildUri(String apiEndPoint, LatLng location) {
  return Uri(
      scheme: 'https',
      host: _apiBaseUrl,
      path: '$_apiPath$apiEndPoint',
      queryParameters: {
        'appid': _apiKey,
        'lat': '${location.lat}',
        'lon': '${location.lng}',
      });
}
