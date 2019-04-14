
import 'package:test/test.dart';
import 'package:google_maps_webservice/places.dart';

void main() {
  test('google maps webservice - place search', () async {
    final places = new GoogleMapsPlaces(apiKey: 'AIzaSyB582MDHjcgKpowp5c8f--P6ZjzuoB8wOA');
    PlacesSearchResponse response = await places.searchByText('강남구', language: 'ko');
    print(response.results.length);
  });
}