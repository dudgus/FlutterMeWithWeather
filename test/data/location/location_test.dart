import 'package:flutter_weather/data/location/location.dart';
import 'package:flutter_weather/data/location/location_model.dart';
import 'package:test/test.dart';

void main() {
  test('get current location', () async {
    var location = await getLocation();
    expect(location, isNotNull);
  });

  test('get address by searky keyword', () async {
    Address address = await getAddress(query: '수원 매탄동');
    expect(address.formatted, contains('매탄동'));
  });

  test('get address by current lat & lng', () async {
    // 37.2593553, 127.0547372 - 매탄동
    var location = LatLng(37.2593553, 127.0547372);
    List<Address> addresses = await getAddresses(location: location);
    addresses.forEach((address) => print(address.formatted));
    expect(addresses.length > 0, true);
  });
}
