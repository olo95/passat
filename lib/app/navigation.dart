import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passat/app/pages/location_forecast/location_forecast_page.dart';
import 'package:passat/app/pages/search_result/search_result_page.dart';
import 'package:passat/data/models/search_result/search_result_page_list_item_model.dart';

class Navigation extends InheritedWidget {
  const Navigation({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static Navigation of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Navigation>();

  @override
  bool updateShouldNotify(Navigation old) => false;

  Future<void> getToSearchResultPage(BuildContext context,
          List<SearchResultPageListItemModel> listDataSource) =>
      _push(context, (context) => SearchResultPage(listDataSource));

  Future<void> getToLocationForecastPage(BuildContext context, String id) =>
      _push(context, (context) => LocationForecastPage());

  void pop<T>(BuildContext context, [T result]) => _pop(context, result);

  Future<T> _push<T>(BuildContext context, WidgetBuilder builder) =>
      Navigator.push<T>(context, MaterialPageRoute(builder: builder));

  void _pop<T>(BuildContext context, T result) =>
      Navigator.pop(context, result);
}
