import 'package:async/async.dart';

abstract class SearchLocationsRepository {
  Future<Result<List<String>>> search(String query);
}
