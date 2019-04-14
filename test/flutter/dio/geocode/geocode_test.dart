import 'package:dio/dio.dart';
import 'package:flutter_weather/data/location/location.dart';
import 'package:flutter_weather/data/location/location_model.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

void main() {
  group('get address by search keyword', () {
    Response response;

    setUpAll(() async {
      Uri uri = _buildSearchUri(key: 'address', value: '수원 매탄동');
      response = await Dio().get(uri.toString());
    });

    test('check response', () {
      expect(response, isNotNull);
      expect(response.statusCode, equals(200));
    });

    test('check json serialized data', () {
      List<Address> addresses = _toAddressList(response.data);
      print(addresses[0].formatted);
    });
  });

  group('get address by lat & lng', () {
    Response response;

    setUpAll(() async {
      LatLng location = await getLocation();
      final uri = _buildSearchUri(
          key: 'latlng', value: '${location.lat},${location.lng}');
      response = await Dio().get(uri.toString());
    });

    test('check response', () {
      expect(response, isNotNull);
      expect(response.statusCode, equals(200));
    });

    test('check json serialized data', () {
      List<Address> addresses = _toAddressList(response.data);
      addresses.forEach((address) => { print(address.formatted) });
    });
  });
}

Uri _buildSearchUri(
    {String lang = 'ko', @required String key, @required String value}) {
  final String apiBaseUrl = 'maps.googleapis.com';
  final String apiPath = '/maps/api';
  final String apiEndPoint = '/geocode/json';
  final String apiKey = 'AIzaSyB582MDHjcgKpowp5c8f--P6ZjzuoB8wOA';

  return Uri(
      scheme: 'https',
      host: apiBaseUrl,
      path: '$apiPath$apiEndPoint',
      queryParameters: {
        'language': lang,
        'key': apiKey,
        key: value,
      });
}

List<Address> _toAddressList(json) {
  Iterable l = json['results'];
  return l.map((model) => Address.fromJson(model)).toList();
}