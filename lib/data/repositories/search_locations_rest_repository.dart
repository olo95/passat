import 'package:async/src/result/result.dart';
import 'package:passat/data/api/api_paths.dart';
import 'package:passat/data/api/http_client.dart';
import 'package:passat/domain/repositories/search_locations_repository.dart';

class SearchLocationsRestRepository implements SearchLocationsRepository {
  SearchLocationsRestRepository._(this._httpClient);

  factory SearchLocationsRestRepository.build() =>
      SearchLocationsRestRepository._(HttpClient());

  final HttpClient _httpClient;

  @override
  Future<Result<List<String>>> search(String query) async {
    final requestUri =
        Uri.http(ApiPaths.search, '', <String, String>{'query': query});

    final result = await _httpClient.getRequest(requestUri.path);

    if (result.isValue) {
      
    } else if (result.isError) {

    } else {

    }
  }
}
