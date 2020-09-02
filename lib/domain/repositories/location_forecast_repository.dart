import 'package:async/async.dart';
import 'package:passat/domain/entities/location_forecast.dart';

abstract class LocationForecastRepository {
  Future<Result<LocationForecast>> get(int woeid);
}
