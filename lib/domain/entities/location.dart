import 'package:json_annotation/json_annotation.dart';

part '../../domain/entities/location.g.dart';

@JsonSerializable()
class Location {
  Location(this.title, this.locationType, this.woeid, this.lattLong);

  @JsonKey()
  String title;

  @JsonKey(name: 'location_type')
  String locationType;

  @JsonKey()
  int woeid;

  @JsonKey(name: 'latt_long')
  String lattLong;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
