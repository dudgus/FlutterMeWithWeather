import 'package:dio/dio.dart';
import 'package:flutter_weather/data/location/location_model.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

final String _apiBaseUrl = 'maps.googleapis.com';
final String _apiPath = '/maps/api';
final String _apiEndPoint = '/geocode/json';
final String _apiKey = 'AIzaSyB582MDHjcgKpowp5c8f--P6ZjzuoB8wOA';

Future<LatLng> getLocation() async {
  var latLng;
  try {
    LocationData data = await Location().getLocation();
    latLng = LatLng(data.latitude, data.longitude);
  } catch (e) {
    latLng = LatLng(.0, .0);
  }
  return latLng;
}

Future<Address> getAddress({@required String query}) async {
  final Dio dio = Dio();
  final uri = _buildSearchUri(key: 'address', value: query);

  Response response = await dio.get(uri.toString());
  List<Address> addresses = _toAddressList(response.data);

  return (addresses.length > 0 ? addresses[0] : null);
}

Future<List<Address>> getAddresses({@required LatLng location}) async {
  final Dio dio = Dio();
  final uri = _buildSearchUri(key: 'latlng', value: '${location.lat},${location.lng}');

  Response response = await dio.get(uri.toString());
  List<Address> addresses = _toAddressList(response.data);

  return addresses.where((address) => address.components.length > 2).toList();
}


Uri _buildSearchUri(
    {String lang = 'ko', @required String key, @required String value}) {
  return Uri(
      scheme: 'https',
      host: _apiBaseUrl,
      path: '$_apiPath$_apiEndPoint',
      queryParameters: {
        'language': lang,
        'key': _apiKey,
        key: value,
      });
}

List<Address> _toAddressList(json) {
  Iterable l = json['results'];
  return l.map((model) => Address.fromJson(model)).toList();
}
