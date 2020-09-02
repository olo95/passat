import 'package:async/src/result/result.dart';
import 'package:passat/data/api/api_exception.dart';
import 'package:passat/data/api/api_paths.dart';
import 'package:passat/data/api/http_client.dart';
import 'package:passat/domain/entities/location.dart';
import 'package:passat/domain/entities/location_list.dart';
import 'package:passat/domain/repositories/search_locations_repository.dart';

class SearchLocationsRestRepository implements SearchLocationsRepository {
  SearchLocationsRestRepository._(this._httpClient);

  factory SearchLocationsRestRepository.build() =>
      SearchLocationsRestRepository._(HttpClient());

  final HttpClient _httpClient;

  @override
  Future<Result<List<Location>>> search(String query) async {

    final requestUri = Uri.https(ApiPaths.authority, ApiPaths.search, <String, String>{'query': query});

    final result = await _httpClient.getRequest(requestUri);

    if (result.isValue) {
      final mapResult = <String, dynamic> {'value': result.asValue.value};
      final list =
          LocationList.fromJson(mapResult);

      return Result<List<Location>>.value(list.value);
    } else if (result.isError) {
      return Result<List<Location>>.error(result.asError.error);
    } else {
      return Result<List<Location>>.error(UnknownException());
    }
  }
}
