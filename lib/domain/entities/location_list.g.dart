// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../domain/entities/location_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationList _$LocationListFromJson(Map<String, dynamic> json) {
  return LocationList(
    (json['value'] as List)
        ?.map((e) =>
            e == null ? null : Location.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationListToJson(LocationList instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
