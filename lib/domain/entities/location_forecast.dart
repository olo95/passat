import 'package:json_annotation/json_annotation.dart';
import 'package:passat/domain/entities/forecast.dart';
import 'package:passat/domain/entities/parent.dart';
import 'package:passat/domain/entities/source.dart';

part 'location_forecast.g.dart';

@JsonSerializable()
class LocationForecast {
  LocationForecast(this.consolidatedWeather, this.time, this.sunRise,
      this.sunSet, this.timezoneName, this.parent, this.sources, this.title,
      this.locationType, this.woeid, this.lattLong, this.timezone);

  @JsonKey(name: 'consolidated_weather')
  List<Forecast> consolidatedWeather;

  @JsonKey()
  DateTime time;

  @JsonKey(name: 'sun_rise')
  DateTime sunRise;

  @JsonKey(name: 'sun_set')
  DateTime sunSet;

  @JsonKey(name: 'timezone_name')
  String timezoneName;

  @JsonKey()
  Parent parent;

  @JsonKey()
  List<Source> sources;

  @JsonKey()
  String title;

  @JsonKey(name: 'location_type')
  String locationType;

  @JsonKey()
  int woeid;

  @JsonKey(name: 'latt_long')
  String lattLong;

  @JsonKey()
  String timezone;

  factory LocationForecast.fromJson(Map<String, dynamic> json) =>
      _$LocationForecastFromJson(json);

  Map<String, dynamic> toJson() => _$LocationForecastToJson(this);
}