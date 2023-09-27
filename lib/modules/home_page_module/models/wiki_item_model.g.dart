// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WikiItemModel _$WikiItemModelFromJson(Map<String, dynamic> json) =>
    WikiItemModel(
      pageid: json['pageid'] as int,
      title: json['title'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$WikiItemModelToJson(WikiItemModel instance) =>
    <String, dynamic>{
      'pageid': instance.pageid,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      json['source'] as String?,
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'source': instance.source,
    };
