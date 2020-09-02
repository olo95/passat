import 'package:flutter/material.dart';
import 'package:passat/data/models/search_result/search_result_page_list_item_model.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage(this._listDataSource);

  final List<SearchResultPageListItemModel> _listDataSource;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Choose location'),
        ),
        body: ListView.builder(
          itemCount: _listDataSource.length,
          itemBuilder: (BuildContext context, int index) => Material(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(_listDataSource[index].title),
                ),
              ),
            ),
          ),
        ),
      );
}
