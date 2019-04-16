// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
      (json['address_components'] as List)
          ?.map((e) => e == null
              ? null
              : AddressComponent.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['formatted_address'] as String,
      json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>));
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address_components': instance.components,
      'formatted_address': instance.formatted,
      'geometry': instance.geometry
    };

AddressComponent _$AddressComponentFromJson(Map<String, dynamic> json) {
  return AddressComponent(
      json['long_name'] as String,
      json['short_name'] as String,
      (json['types'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$AddressComponentToJson(AddressComponent instance) =>
    <String, dynamic>{
      'long_name': instance.longName,
      'short_name': instance.shortName,
      'types': instance.types
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(json['location'] == null
      ? null
      : LatLng.fromJson(json['location'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) =>
    <String, dynamic>{'location': instance.location};

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
      (json['lat'] as num)?.toDouble(), (json['lng'] as num)?.toDouble());
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};
