import 'package:async/async.dart';
import 'package:passat/data/api/api_exception.dart';
import 'package:passat/data/models/search_result/search_result_page_list_item_model.dart';
import 'package:passat/data/provider/search_page_provider_model_state.dart';
import 'package:passat/data/repositories/search_locations_rest_repository.dart';
import 'package:passat/domain/entities/location.dart';
import 'package:passat/domain/provider/provider_model.dart';
import 'package:passat/domain/repositories/search_locations_repository.dart';

class SearchPageProviderModel
    extends ProviderModel<SearchPageProviderModelState> {
  SearchPageProviderModel._(SearchPageProviderModelState initialValue,
      SearchLocationsRepository searchLocationsRepository)
      : _searchLocationsRepository = searchLocationsRepository,
        super(initialValue);

  factory SearchPageProviderModel.build() => SearchPageProviderModel._(
      SearchPageProviderModelState(), SearchLocationsRestRepository.build());

  final SearchLocationsRepository _searchLocationsRepository;

  Future<void> searchLocations(String query) {
    final searchResult = _searchLocationsRepository.search(query);

    return value.listModel.set(_builder(searchResult), notifyListeners);
  }

  Future<Result<List<SearchResultPageListItemModel>>> _builder(
          Future<Result<List<Location>>> future) =>
      future.then((Result<List<Location>> value) {
        if (value.isValue) {
          return Result<List<SearchResultPageListItemModel>>.value(value
              .asValue.value
              .map((Location element) =>
                  SearchResultPageListItemModel(element.woeid, element.title))
              .toList());
        } else if (value.isError) {
          return Result<List<SearchResultPageListItemModel>>.error(
              value.asError.error);
        } else {
          return Result<List<SearchResultPageListItemModel>>.error(
              UnknownException());
        }
      });
}
