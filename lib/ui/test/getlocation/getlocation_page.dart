import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_weather/data/location/location.dart';
import 'package:flutter_weather/data/location/model/location_model.dart';

class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
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
