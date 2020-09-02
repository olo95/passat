import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable()
class Parent {
  Parent(this.title, this.locationType, this.woeid, this.lattLong);

  @JsonKey()
  String title;

  @JsonKey(name: 'location_type')
  String locationType;

  @JsonKey()
  int woeid;

  @JsonKey(name: 'latt_long')
  String lattLong;

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
