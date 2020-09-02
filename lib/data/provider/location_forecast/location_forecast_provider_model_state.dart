import 'package:passat/data/models/location_forecast/location_forecast_model.dart';
import 'package:passat/domain/provider/provider_model_async_result.dart';

class LocationForecastProviderModelState {
  final forecastModel = ProviderModelAsyncResult<LocationForecastModel>();
}