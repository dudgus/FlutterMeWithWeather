import 'package:flutter_weather/data/location/location.dart';
import 'package:test/test.dart';

void main() {
  test("get current location", () async {
    var latLng = await getLocation();
    expect(latLng, isNot(null));
    print('Location : ${latLng.latitude} ${latLng.longitude}!!');
  });
}
