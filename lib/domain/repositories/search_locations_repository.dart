import 'package:async/async.dart';
import 'package:passat/domain/entities/location.dart';

abstract class SearchLocationsRepository {
  Future<Result<List<Location>>> search(String query);
}
