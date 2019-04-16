import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class Address {
  @JsonKey(name: 'address_components')
  final List<AddressComponent> components;

  @JsonKey(name: 'formatted_address')
  final String formatted;

  final Geometry geometry;

  Address(this.components, this.formatted, this.geometry);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@JsonSerializable()
class AddressComponent {
  @JsonKey(name: 'long_name')
  final String longName;
  @JsonKey(name: 'short_name')
  final String shortName;
  final List<String> types;

  AddressComponent(this.longName, this.shortName, this.types);

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentFromJson(json);
}

@JsonSerializable()
class Geometry {
  final LatLng location;

  Geometry(this.location);

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

@JsonSerializable()
class LatLng {
  final double lat;
  final double lng;

  LatLng(this.lat, this.lng);

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
}
