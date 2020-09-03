// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return Forecast(
    json['id'] as int,
    json['weather_state_name'] as String,
    json['weather_state_abbr'] as String,
    json['wind_direction_compass'] as String,
    json['created'] == null ? null : DateTime.parse(json['created'] as String),
    Forecast.fromJsonToLocal(json['applicable_date'] as String),
    (json['min_temp'] as num)?.toDouble(),
    (json['max_temp'] as num)?.toDouble(),
    (json['the_temp'] as num)?.toDouble(),
    (json['wind_speed'] as num)?.toDouble(),
    (json['wind_direction'] as num)?.toDouble(),
    (json['air_pressure'] as num)?.toDouble(),
    json['humidity'] as int,
    (json['visibility'] as num)?.toDouble(),
    json['predictability'] as int,
  );
}

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'id': instance.id,
      'weather_state_name': instance.weatherStateName,
      'weather_state_abbr': instance.weatherStateAbbr,
      'wind_direction_compass': instance.windDirectionCompass,
      'created': instance.created?.toIso8601String(),
      'applicable_date': instance.applicableDate?.toIso8601String(),
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'the_temp': instance.theTemp,
      'wind_speed': instance.windSpeed,
      'wind_direction': instance.windDirection,
      'air_pressure': instance.airPressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'predictability': instance.predictability,
    };
