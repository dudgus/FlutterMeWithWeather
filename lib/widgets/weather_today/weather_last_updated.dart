import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

class WeatherLastUpdated extends StatelessWidget {
  final DateTime dateTime;

  WeatherLastUpdated({Key key, @required this.dateTime})
      : assert(dateTime != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Updated: ${dateTime.month.toString()}/${dateTime.day.toString()} ${TimeOfDay.fromDateTime(dateTime).format(context)}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w200,
        color: Colors.white,
      ),
    );
  }
}
