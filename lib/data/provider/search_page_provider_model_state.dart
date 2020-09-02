import 'package:passat/data/models/search/search_page_list_item_model.dart';
import 'package:passat/domain/provider/provider_model_async_result.dart';

class SearchPageProviderModelState {
  final listModel = ProviderModelAsyncResult<List<SearchPageListItemModel>>();
}