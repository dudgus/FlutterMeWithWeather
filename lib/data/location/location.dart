import 'package:location/location.dart';

class LatLng {
  double latitude;
  double longitude;

  LatLng({this.latitude, this.longitude});
}

Future<LatLng> getLocation() async {
  var latLng = LatLng(latitude: .0, longitude: .0);
  try {
    LocationData data = await Location().getLocation();
    latLng.latitude = data.latitude;
    latLng.longitude = data.longitude;
  } catch (e) {}
  return latLng;
}


