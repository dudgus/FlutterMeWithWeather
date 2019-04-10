import 'package:dio/dio.dart';
import 'package:flutter_weather/data/location/location.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

void main() {
  test('get address by search keyword', () async {
    final Dio dio = Dio();
    final uri = buildSearchUri(key: 'address', value: '매탄3동');

    print(uri.toString());

    Response response = await dio.get(uri.toString());
    expect(response, isNotNull);

    print(response.statusCode);
    print(response.data);
  });

  test('get address by latlng', () async {
    final latLng = await getLocation();

    final Dio dio = Dio();
    final uri = buildSearchUri(
        key: 'latlng', value: '${latLng.latitude},${latLng.longitude}');

    print(uri.toString());

    Response response = await dio.get(uri.toString());
    expect(response, isNotNull);

    print(response.statusCode);
    print(response.data);
  });
}

Uri buildSearchUri({@required String key, @required String value}) {
  final String apiBaseUrl = 'maps.googleapis.com';
  final String apiPath = '/maps/api';
  final String apiEndPoint = '/geocode/json';
  final String apiKey = 'AIzaSyB582MDHjcgKpowp5c8f--P6ZjzuoB8wOA';

  return Uri(
      scheme: 'https',
      host: apiBaseUrl,
      path: '$apiPath$apiEndPoint',
      queryParameters: {
        'language': 'ko',
        'key': apiKey,
        key: value,
      });
}
