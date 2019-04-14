import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/location_bloc.dart';
import 'package:flutter_weather/bloc/weather_bloc.dart';
import 'package:flutter_weather/data/weather/weather_model.dart';

class WeatherPage extends StatefulWidget {
  final location;
  final WeatherBloc _weatherBloc;

  WeatherPage({this.location})
      : _weatherBloc = WeatherBloc();

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Center(
        child: Text('Flutter Me with Weather'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildBody() {
    widget._weatherBloc.updateCurrentWeather();

    return StreamBuilder(
      stream: widget._weatherBloc.weather,
      builder: (context, AsyncSnapshot<Weather> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        Summary summary = snapshot.data.summary[0];

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'http://openweathermap.org/img/w/${summary.icon}.png'),
            Text(snapshot.data.name),
            Text(summary.description),
          ],
        );
      },
    );
  }
}
