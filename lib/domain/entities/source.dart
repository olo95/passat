import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source {
  Source(this.title, this.slug, this.url, this.crawlRate);

  @JsonKey()
  String title;

  @JsonKey()
  String slug;

  @JsonKey()
  String url;

  @JsonKey(name: 'crawl_rate')
  int crawlRate;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
