import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_weather/data/location/location.dart';
import 'package:flutter_weather/data/location/location_model.dart';

class CurrentLocationPage extends StatefulWidget {
  @override
  _CurrentLocationPageState createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: getLocation(),
          builder: (context, AsyncSnapshot<LatLng> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return Text(
              "Location: ${snapshot.data.lat} ${snapshot.data.lng}",
            );
          },
        ),
      ),
    );
  }
}
