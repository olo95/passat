// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parent _$ParentFromJson(Map<String, dynamic> json) {
  return Parent(
    json['title'] as String,
    json['location_type'] as String,
    json['woeid'] as int,
    json['latt_long'] as String,
  );
}

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'title': instance.title,
      'location_type': instance.locationType,
      'woeid': instance.woeid,
      'latt_long': instance.lattLong,
    };
