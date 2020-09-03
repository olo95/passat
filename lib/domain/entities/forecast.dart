import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable()
class Forecast {
  Forecast(
      this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.windDirectionCompass,
      this.created,
      this.applicableDate,
      this.minTemp,
      this.maxTemp,
      this.theTemp,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.predictability);

  @JsonKey()
  int id;

  @JsonKey(name: 'weather_state_name')
  String weatherStateName;

  @JsonKey(name: 'weather_state_abbr')
  String weatherStateAbbr;

  @JsonKey(name: 'wind_direction_compass')
  String windDirectionCompass;

  @JsonKey()
  DateTime created;

  @JsonKey(name: 'applicable_date', fromJson: fromJsonToLocal)
  DateTime applicableDate;

  @JsonKey(name: 'min_temp')
  double minTemp;

  @JsonKey(name: 'max_temp')
  double maxTemp;

  @JsonKey(name: 'the_temp')
  double theTemp;

  @JsonKey(name: 'wind_speed')
  double windSpeed;

  @JsonKey(name: 'wind_direction')
  double windDirection;

  @JsonKey(name: 'air_pressure')
  double airPressure;

  @JsonKey()
  int humidity;

  @JsonKey()
  double visibility;

  @JsonKey()
  int predictability;

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);

  static DateTime fromJsonToLocal(String date) =>
      date != null ? DateTime.parse(date).toLocal() : null;
}
