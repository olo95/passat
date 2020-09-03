import 'package:json_annotation/json_annotation.dart';
import 'package:passat/domain/entities/location.dart';

part 'location_list.g.dart';

@JsonSerializable()
class LocationList {
  LocationList(this.value);

  @JsonKey()
  List<Location> value;

  factory LocationList.fromJson(Map<String, dynamic> json) =>
      _$LocationListFromJson(json);

  Map<String, dynamic> toJson() => _$LocationListToJson(this);
}
