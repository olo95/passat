import 'package:flutter/material.dart';
import 'package:passat/app/navigation.dart';
import 'package:passat/data/app_colors.dart';
import 'package:passat/data/models/search_result/search_result_page_list_item_model.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage(this._listDataSource);

  final List<SearchResultPageListItemModel> _listDataSource;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Choose location'),
        ),
        body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Container(
            height: 1,
            color: AppColors.textPrimary.withAlpha(10),
          ),
          itemCount: _listDataSource.length,
          itemBuilder: (BuildContext context, int index) => Material(
            child: InkWell(
              onTap: () {
                Future.microtask(() => Navigation.of(context)
                    .getToLocationForecastPage(
                        context, _listDataSource[index].id));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(_listDataSource[index].title),
                ),
              ),
            ),
          ),
        ),
      );
}
