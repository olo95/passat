import 'package:passat/data/models/location_forecast/location_forecast_list_item_model.dart';

class LocationForecastModel {
  LocationForecastModel(this.locationName, this.listItemModelList) {
    selectedWeatherId = listItemModelList.first.id;
  }

  String locationName;
  int selectedWeatherId;
  List<LocationForecastListItemModel> listItemModelList;
}
