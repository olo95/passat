import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    modelState ??=
        Provider.of<LocationForecastProviderModel>(context, listen: true)
            .getForecast();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => _content(context);

  Widget _content(BuildContext context) {
    final locationForecast = context.select(
        (LocationForecastProviderModel model) => model.value.forecastModel);

    if (locationForecast.result.isError) {
      Future.microtask(() => showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Failed to download forecast'),
                actions: [
                  InkWell(
                    child: Text('Retry'),
                    onTap: () {
                      Provider.of<LocationForecastProviderModel>(context,
                              listen: false)
                          .getForecast();
                    },
                  )
                ],
              )));
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: (() {
          return Provider.of<LocationForecastProviderModel>(context,
                  listen: false)
              .getForecast();
        }),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) =>
              SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: viewportConstraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selectedWeather(locationForecast),
                  Container(height: 150, child: _weatherList(locationForecast))
                ],
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
        return shimmeringContainer();
        break;
      case ProviderModelAsyncResultState.done:
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
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: shimmeringContainer(),
        );
        break;
      case ProviderModelAsyncResultState.done:
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

  Widget shimmeringContainer() => Flexible(
        fit: FlexFit.tight,
        child: Container(
          color: Colors.grey.withAlpha(50),
          child: Shimmer.fromColors(
            baseColor: Colors.white70,
            highlightColor: Colors.grey,
            child: Container(
              color: Colors.white24,
            ),
          ),
        ),
      );
}
