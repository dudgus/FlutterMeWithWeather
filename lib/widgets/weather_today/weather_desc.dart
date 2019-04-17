import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

class WeatherDesc extends StatelessWidget {
  final String desc;

  WeatherDesc({Key key, @required this.desc})
      : assert(desc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      desc,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
