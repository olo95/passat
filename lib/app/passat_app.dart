import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passat/app/navigation.dart';
import 'package:passat/app/pages/search/search_page.dart';
import 'package:passat/data/app_theme.dart';
import 'package:passat/data/provider/search/search_page_provider_model.dart';
import 'package:passat/domain/provider/provider_widget.dart';

class PassatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Navigation(
        child: MaterialApp(
          theme: AppThemeDataFactory.prepareThemeData(),
          home: ProviderWidget<SearchPageProviderModel>(SearchPage.build(),
              (BuildContext context) => SearchPageProviderModel.build()),
        ),
      );
}
