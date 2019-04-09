import 'package:location/location.dart';
import 'package:test/test.dart';

void main() {
  test("get current location", () async {
    var location = Location();
    LocationData data = await location.getLocation();
    expect(data, isNot(null));
    print('Location : ${data.latitude} ${data.longitude}');
  });
}