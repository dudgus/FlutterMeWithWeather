import 'package:flutter/material.dart';
import 'package:location/location.dart';

class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  var location = new Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: _getLocation(),
          builder: (context, AsyncSnapshot<LocationData> location) {
            if (location.data == null)
              return Text(
                'Location is loading',
              );

            return Text(
              "Location: ${location.data.latitude.toString()} ${location.data.longitude.toString()}",
            );
          },
        ),
      ),
    );
  }

  Future<LocationData> _getLocation() async {
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
