// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
      json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      (json['weather'] as List)
          ?.map((e) =>
              e == null ? null : Summary.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['wind'] == null
          ? null
          : Wind.fromJson(json['wind'] as Map<String, dynamic>),
      json['clouds'] == null
          ? null
          : Cloud.fromJson(json['clouds'] as Map<String, dynamic>),
      json['dt'] as int,
      json['dt_txt'] as String,
      json['name'] as String);
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.main,
      'weather': instance.summary,
      'wind': instance.wind,
      'clouds': instance.cloud,
      'dt': instance.time,
      'dt_txt': instance.timeText,
      'name': instance.name
    };

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
      (json['temp'] as num)?.toDouble(),
      (json['temp_min'] as num)?.toDouble(),
      (json['temp_max'] as num)?.toDouble(),
      (json['pressure'] as num)?.toDouble(),
      (json['humidity'] as num)?.toDouble());
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) {
  return Summary(json['id'] as int, json['main'] as String,
      json['description'] as String, json['icon'] as String);
}

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
      (json['speed'] as num)?.toDouble(), (json['deg'] as num)?.toDouble());
}

Map<String, dynamic> _$WindToJson(Wind instance) =>
    <String, dynamic>{'speed': instance.speed, 'deg': instance.deg};

Cloud _$CloudFromJson(Map<String, dynamic> json) {
  return Cloud((json['all'] as num)?.toDouble());
}

Map<String, dynamic> _$CloudToJson(Cloud instance) =>
    <String, dynamic>{'all': instance.all};
