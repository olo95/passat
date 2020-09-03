import 'package:async/async.dart';
import 'package:passat/data/api/api_exception.dart';
import 'package:passat/data/models/location_forecast/location_forecast_list_item_model.dart';
import 'package:passat/data/models/location_forecast/location_forecast_model.dart';
import 'package:passat/data/policies/day_of_the_week_policy.dart';
import 'package:passat/data/policies/humidity_policy.dart';
import 'package:passat/data/policies/pressure_policy.dart';
import 'package:passat/data/policies/temperature_policy.dart';
import 'package:passat/data/policies/weather_image_policy.dart';
import 'package:passat/data/policies/wind_policy.dart';
import 'package:passat/data/provider/location_forecast/location_forecast_provider_model_state.dart';
import 'package:passat/data/repositories/location_forecast_rest_repository.dart';
import 'package:passat/domain/entities/forecast.dart';
import 'package:passat/domain/entities/location_forecast.dart';
import 'package:passat/domain/policies/day_of_the_week_policy_type.dart';
import 'package:passat/domain/policies/humidity_policy_type.dart';
import 'package:passat/domain/policies/pressure_policy_type.dart';
import 'package:passat/domain/policies/temperature_policy_type.dart';
import 'package:passat/domain/policies/weather_image_policy_type.dart';
import 'package:passat/domain/policies/wind_policy_type.dart';
import 'package:passat/domain/provider/provider_model.dart';
import 'package:passat/domain/repositories/location_forecast_repository.dart';

class LocationForecastProviderModel
    extends ProviderModel<LocationForecastProviderModelState> {
  LocationForecastProviderModel._(
      LocationForecastProviderModelState initialValue,
      this._locationForecastRepository,
      this._locationId,
      this._dayOfTheWeekPolicy,
      this._humidityPolicy,
      this._pressurePolicy,
      this._temperaturePolicy,
      this._windPolicy,
      this._weatherImagePolicy)
      : super(initialValue);

  factory LocationForecastProviderModel.build(int locationId) =>
      LocationForecastProviderModel._(
          LocationForecastProviderModelState(),
          LocationForecastRestRepository.build(),
          locationId,
          DayOfTheWeekPolicy(),
          HumidityPolicy(),
          PressurePolicy(),
          TemperaturePolicy(),
          WindPolicy(),
          WeatherImagePolicy());

  final LocationForecastRepository _locationForecastRepository;
  final int _locationId;
  final DayOfTheWeekPolicyType _dayOfTheWeekPolicy;
  final HumidityPolicyType _humidityPolicy;
  final PressurePolicyType _pressurePolicy;
  final TemperaturePolicyType _temperaturePolicy;
  final WindPolicyType _windPolicy;
  final WeatherImagePolicyType _weatherImagePolicy;

  Future<void> getForecast() {
    final locationForecastResult = _locationForecastRepository.get(_locationId);

    return value.forecastModel
        .set(_resultTransformBuilder(locationForecastResult), notifyListeners);
  }

  void selectWeather(int id) {
    if (value.forecastModel.result.isValue) {
      value.forecastModel.result.asValue.value.selectedWeatherId = id;

      notifyListeners();
    }
  }

  Future<Result<LocationForecastModel>> _resultTransformBuilder(
          Future<Result<LocationForecast>> future) =>
      future.then((Result<LocationForecast> value) {
        if (value.isValue) {
          return Result<LocationForecastModel>.value(
              _fromLocationForecast(value.asValue.value));
        } else if (value.isError) {
          return Result<LocationForecastModel>.error(value.asError.error);
        } else {
          return Result<LocationForecastModel>.error(UnknownException());
        }
      });

  LocationForecastModel _fromLocationForecast(
      LocationForecast locationForecast) {
    final list = locationForecast.consolidatedWeather
        .map((Forecast element) => LocationForecastListItemModel(
            element.id,
            element.weatherStateName,
            _dayOfTheWeekPolicy.fullName(element.applicableDate),
            _dayOfTheWeekPolicy.shortName(element.applicableDate),
            _temperaturePolicy.inCelcius(element.theTemp),
            _temperaturePolicy.inCelcius(element.maxTemp),
            _temperaturePolicy.inCelcius(element.minTemp),
            _humidityPolicy.asString(element.humidity),
            _pressurePolicy.asString(element.airPressure),
            _windPolicy.asString(element.windSpeed),
            _weatherImagePolicy.get(element.weatherStateAbbr)))
        .toList();

    return LocationForecastModel(locationForecast.title, list);
  }
}
