import 'package:flutter/material.dart';
import 'package:passat/data/models/location_forecast/location_forecast_model.dart';
import 'package:passat/data/provider/location_forecast/location_forecast_provider_model.dart';
import 'package:passat/domain/provider/provider_model_async_result.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(locationForecast),
      ),
    );
  }

  Widget _appBarTitle(ProviderModelAsyncResult<LocationForecastModel> model) {
    switch (model.state) {
      case ProviderModelAsyncResultState.none:
      case ProviderModelAsyncResultState.active:
        return CircularProgressIndicator();
        break;
      case ProviderModelAsyncResultState.done:
        return Text(model.result.isValue
            ? model.result.asValue.value.title
            : 'Location title');
        break;
    }

    return Text('Location title');
  }
}
