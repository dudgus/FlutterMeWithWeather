import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class Weather {

  final Main main;

  @JsonKey(name: 'weather')
  final List<Summary> summary;

  final Wind wind;

  @JsonKey(name: 'clouds')
  final Cloud cloud;

  @JsonKey(name: 'dt')
  final int time;

  String name;

  Weather(this.main, this.summary, this.wind, this.cloud, this.time, this.name);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@JsonSerializable()
class Main {
  final double temp;

  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;

  final double pressure;
  final double humidity;

  Main(this.temp, this.tempMin, this.tempMax, this.pressure, this.humidity);

  factory Main.fromJson(Map<String, dynamic> json) =>
      _$MainFromJson(json);
}

///
/// https://openweathermap.org/weather-conditions
///
@JsonSerializable()
class Summary {

  final int id;
  final String main;
  final String description;
  final String icon;

  Summary(this.id, this.main, this.description, this.icon);

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  String toString() {
    return '$id - $main: $description, $icon';
  }
}


@JsonSerializable()
class Wind {
  final double speed;
  final double deg;

  Wind(this.speed, this.deg);

  factory Wind.fromJson(Map<String, dynamic> json) =>
      _$WindFromJson(json);
}

@JsonSerializable()
class Cloud {
  final double all;

  Cloud(this.all);

  factory Cloud.fromJson(Map<String, dynamic> json) =>
      _$CloudFromJson(json);
}
