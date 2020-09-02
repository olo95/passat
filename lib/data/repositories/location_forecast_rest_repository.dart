import 'package:async/src/result/result.dart';
import 'package:passat/data/api/api_exception.dart';
import 'package:passat/data/api/api_paths.dart';
import 'package:passat/data/api/http_client.dart';
import 'package:passat/domain/entities/location_forecast.dart';
import 'package:passat/domain/repositories/location_forecast_repository.dart';

class LocationForecastRestRepository implements LocationForecastRepository {
  LocationForecastRestRepository._(this._httpClient);

  factory LocationForecastRestRepository.build() =>
      LocationForecastRestRepository._(HttpClient());

  final HttpClient _httpClient;

  @override
  Future<Result<LocationForecast>> get(int woeid) async {
    final requestUri = Uri.https(
      ApiPaths.authority,
      ApiPaths.location + '/$woeid',
    );

    final result = await _httpClient.getRequest(requestUri);

    if (result.isValue) {
      final locationForecast = LocationForecast.fromJson(
          result.asValue.value as Map<String, dynamic>);

      return Result<LocationForecast>.value(locationForecast);
    } else if (result.isError) {
      return Result<LocationForecast>.error(result.asError.error);
    } else {
      return Result<LocationForecast>.error(UnknownException());
    }
  }
}
