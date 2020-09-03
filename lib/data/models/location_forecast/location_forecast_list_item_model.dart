import 'package:flutter/widgets.dart';

class LocationForecastListItemModel {
  LocationForecastListItemModel(
      this.id,
      this.weatherName,
      this.dayFullName,
      this.dayShortName,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.humidity,
      this.pressure,
      this.wind,
      this.weatherImage);

  final int id;
  final String weatherName;
  final String dayFullName;
  final String dayShortName;
  final String temperature;
  final String maxTemperature;
  final String minTemperature;
  final String humidity;
  final String pressure;
  final String wind;
  final Widget weatherImage;
}
