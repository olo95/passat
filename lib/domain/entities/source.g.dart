// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Source _$SourceFromJson(Map<String, dynamic> json) {
  return Source(
    json['title'] as String,
    json['slug'] as String,
    json['url'] as String,
    json['crawl_rate'] as int,
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'url': instance.url,
      'crawl_rate': instance.crawlRate,
    };
