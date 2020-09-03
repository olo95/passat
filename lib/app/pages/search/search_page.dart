import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passat/app/navigation.dart';
import 'package:passat/data/app_colors.dart';
import 'package:passat/data/provider/search/search_page_provider_model.dart';
import 'package:passat/domain/provider/provider_model_async_result.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage._();

  factory SearchPage.build() => SearchPage._();

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchLocationTextFieldController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Search for location'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _textField(),
              const SizedBox(
                height: 16,
              ),
              _button(context)
            ],
          ),
        ),
      );

  Widget _textField() => TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: 'Type in location'),
        textAlign: TextAlign.center,
        controller: _searchLocationTextFieldController,
      );

  Widget _button(BuildContext context) => Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.buttonColor),
        child: InkWell(
          onTap: () {
            Provider.of<SearchPageProviderModel>(context, listen: false)
                .searchLocations(_searchLocationTextFieldController.text);
          },
          child: Center(
            child: Consumer<SearchPageProviderModel>(
              builder: (context, model, child) => _buttonState(model),
            ),
          ),
        ),
      );

  Widget _buttonState(SearchPageProviderModel model) {
    final listModel = model.value.listModel;

    switch (listModel.state) {
      case ProviderModelAsyncResultState.none:
        break;
      case ProviderModelAsyncResultState.active:
        return CircularProgressIndicator();
        break;
      case ProviderModelAsyncResultState.done:
        if (listModel.result.isValue) {
          if (listModel.result.asValue.value.isEmpty) {
            Future.microtask(() => showCupertinoDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text('No results!'),
                    )));
          } else {
            Future.microtask(() => Navigation.of(context).getToSearchResultPage(
                context, listModel.result.asValue.value));
          }
        } else if (listModel.result.isError) {
          Future.microtask(() => showCupertinoDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text('No results!'),
                  )));
        } else {
          Future.microtask(() => showCupertinoDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text('Something went wrong'),
                  )));
        }
        break;
    }

    return Text('SEARCH');
  }
}
