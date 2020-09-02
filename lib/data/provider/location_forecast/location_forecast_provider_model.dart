import 'package:async/async.dart';
import 'package:passat/data/api/api_exception.dart';
import 'package:passat/data/models/location_forecast/location_forecast_model.dart';
import 'package:passat/data/provider/location_forecast/location_forecast_provider_model_state.dart';
import 'package:passat/data/repositories/location_forecast_rest_repository.dart';
import 'package:passat/domain/entities/location_forecast.dart';
import 'package:passat/domain/provider/provider_model.dart';
import 'package:passat/domain/repositories/location_forecast_repository.dart';

class LocationForecastProviderModel
    extends ProviderModel<LocationForecastProviderModelState> {
  LocationForecastProviderModel._(
      LocationForecastProviderModelState initialValue,
      this._locationForecastRepository,
      this._locationId)
      : super(initialValue);

  factory LocationForecastProviderModel.build(int locationId) =>
      LocationForecastProviderModel._(LocationForecastProviderModelState(),
          LocationForecastRestRepository.build(), locationId);

  final LocationForecastRepository _locationForecastRepository;
  final int _locationId;

  Future<void> getForecast() {
    final locationForecastResult = _locationForecastRepository.get(_locationId);

    return value.forecastModel
        .set(_resultTransformBuilder(locationForecastResult), notifyListeners);
  }

  Future<Result<LocationForecastModel>> _resultTransformBuilder(
          Future<Result<LocationForecast>> future) =>
      future.then((Result<LocationForecast> value) {
        if (value.isValue) {
          return Result<LocationForecastModel>.value(
              LocationForecastModel(value.asValue.value.title));
        } else if (value.isError) {
          return Result<LocationForecastModel>.error(value.asError.error);
        } else {
          return Result<LocationForecastModel>.error(UnknownException());
        }
      });
}
