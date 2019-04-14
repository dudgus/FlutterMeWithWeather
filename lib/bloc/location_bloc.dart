import 'package:flutter_weather/data/location/location_model.dart';
import 'package:rxdart/rxdart.dart';

class LocationBloc {
  final _location = PublishSubject<Address>();

  Observable<Address> get location => _location.stream;

  void dispose() {
    _location.close();
  }
}
