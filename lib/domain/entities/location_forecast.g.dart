// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationForecast _$LocationForecastFromJson(Map<String, dynamic> json) {
  return LocationForecast(
    (json['consolidated_weather'] as List)
        ?.map((e) =>
            e == null ? null : Forecast.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['time'] == null ? null : DateTime.parse(json['time'] as String),
    json['sun_rise'] == null
        ? null
        : DateTime.parse(json['sun_rise'] as String),
    json['sun_set'] == null ? null : DateTime.parse(json['sun_set'] as String),
    json['timezone_name'] as String,
    json['parent'] == null
        ? null
        : Parent.fromJson(json['parent'] as Map<String, dynamic>),
    (json['sources'] as List)
        ?.map((e) =>
            e == null ? null : Source.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['title'] as String,
    json['location_type'] as String,
    json['woeid'] as int,
    json['latt_long'] as String,
    json['timezone'] as String,
  );
}

Map<String, dynamic> _$LocationForecastToJson(LocationForecast instance) =>
    <String, dynamic>{
      'consolidated_weather': instance.consolidatedWeather,
      'time': instance.time?.toIso8601String(),
      'sun_rise': instance.sunRise?.toIso8601String(),
      'sun_set': instance.sunSet?.toIso8601String(),
      'timezone_name': instance.timezoneName,
      'parent': instance.parent,
      'sources': instance.sources,
      'title': instance.title,
      'location_type': instance.locationType,
      'woeid': instance.woeid,
      'latt_long': instance.lattLong,
      'timezone': instance.timezone,
    };
