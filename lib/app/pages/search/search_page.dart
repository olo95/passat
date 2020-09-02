import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passat/data/app_colors.dart';
import 'package:passat/data/provider/search_page_provider_model.dart';
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

  Future<void> locationsState;

  @override
  Widget build(BuildContext context) => Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_textField(), _button(context)],
        ),
      );

  Widget _textField() => TextField(
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
          scheduleMicrotask(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('LOADED'),
                  );
                });
          });
        } else if (listModel.result.isError) {
          return Text('ERROR');
        } else {
          return Text('UNKNOWN ERROR');
        }
        break;
    }

    return Text('SEARCH');
  }
}
