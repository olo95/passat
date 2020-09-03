import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passat/app/navigation.dart';
import 'package:passat/data/models/location_forecast/location_forecast_list_item_model.dart';
import 'package:passat/data/models/location_forecast/location_forecast_model.dart';
import 'package:passat/data/provider/location_forecast/location_forecast_provider_model.dart';
import 'package:passat/domain/provider/provider_model_async_result.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LocationForecastPage extends StatefulWidget {
  @override
  _LocationForecastPageState createState() => _LocationForecastPageState();
}

class _LocationForecastPageState extends State<LocationForecastPage> {
  Future<void> modelState;

  @override
  void didChangeDependencies() {
    Future.microtask(() => modelState ??=
        Provider.of<LocationForecastProviderModel>(context, listen: false)
            .getForecast());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Consumer<LocationForecastProviderModel>(
      builder: (context, providerModel, child) =>
          _content(context, providerModel));

  Widget _content(BuildContext contentContext,
      LocationForecastProviderModel providerModel) {
    final locationForecast = providerModel.value.forecastModel;

    if (locationForecast.state == ProviderModelAsyncResultState.done) {
      _showLoadingError(contentContext);
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: (() => Provider.of<LocationForecastProviderModel>(
                contentContext,
                listen: false)
            .getForecast()),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) =>
              SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: viewportConstraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _selectedWeather(locationForecast),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        height: 150, child: _weatherList(locationForecast))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: _appBarTitle(locationForecast),
      ),
    );
  }

  Future _showLoadingError(BuildContext nestedContext) =>
      Future.microtask(() => showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Failed to download forecast'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigation.of(context)..pop(context)..pop(context);
                    },
                    child: Text('Go back'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Provider.of<LocationForecastProviderModel>(nestedContext,
                              listen: false)
                          .getForecast();

                      Navigation.of(context).pop(context);
                    },
                    child: Text('Retry'),
                  )
                ],
              )));

  Widget _appBarTitle(ProviderModelAsyncResult<LocationForecastModel> model) {
    switch (model.state) {
      case ProviderModelAsyncResultState.none:
      case ProviderModelAsyncResultState.active:
        return Container(width: 100, height: 40, child: shimmeringContainer());
        break;
      case ProviderModelAsyncResultState.done:
        return Text(model.result.isValue
            ? model.result.asValue.value.locationName
            : 'Location title');
        break;
    }

    return Text('Location title');
  }

  Widget _selectedWeather(
      ProviderModelAsyncResult<LocationForecastModel> model) {
    switch (model.state) {
      case ProviderModelAsyncResultState.none:
      case ProviderModelAsyncResultState.active:
        return Expanded(child: shimmeringContainer());
        break;
      case ProviderModelAsyncResultState.done:
        if (!model.result.isValue) {
          return shimmeringContainer();
        }

        final value = model.result.asValue.value;
        final itemModel = value.listItemModelList.firstWhere(
            (element) => element.id == value.selectedWeatherId,
            orElse: () => null);

        return _selectedWeatherContent(itemModel);
        break;
    }

    return SizedBox.shrink();
  }

  Widget _selectedWeatherContent(LocationForecastListItemModel model) => Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(model.dayFullName),
                Text(model.weatherName)
              ]),
          Container(width: 200, height: 200, child: model.weatherImage),
          Text(model.temperature),
          Text('Humidity: ${model.humidity}'),
          Text('Pressure: ${model.pressure}'),
          Text('Wind ${model.wind}')
        ],
      );

  Widget _weatherList(ProviderModelAsyncResult<LocationForecastModel> model) {
    switch (model.state) {
      case ProviderModelAsyncResultState.none:
      case ProviderModelAsyncResultState.active:
        return shimmeringContainer();
        break;
      case ProviderModelAsyncResultState.done:
        if (!model.result.isValue) {
          return shimmeringContainer();
        }

        return _weatherListContent(
            model.result.asValue.value.listItemModelList);
        break;
    }

    return SizedBox.shrink();
  }

  Widget _weatherListContent(List<LocationForecastListItemModel> list) =>
      ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            final item = list[index];

            return Container(
              height: 100,
              width: 100,
              child: InkWell(
                onTap: () {
                  Provider.of<LocationForecastProviderModel>(context,
                          listen: false)
                      .selectWeather(item.id);
                },
                child: Column(
                  children: <Widget>[
                    Text(item.dayShortName),
                    Container(
                      width: 50,
                      height: 50,
                      child: item.weatherImage,
                    ),
                    Text('${item.minTemperature}/${item.maxTemperature}')
                  ],
                ),
              ),
            );
          });

  Widget shimmeringContainer() => Container(
        color: Colors.grey.withAlpha(50),
        child: Shimmer.fromColors(
          baseColor: Colors.white70,
          highlightColor: Colors.grey,
          child: Container(
            color: Colors.white24,
          ),
        ),
      );
}
