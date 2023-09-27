// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki_description_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WikiDescriptionModel _$WikiDescriptionModelFromJson(
        Map<String, dynamic> json) =>
    WikiDescriptionModel(
      pageid: json['pageid'] as int?,
      ns: json['ns'] as int?,
      title: json['title'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      pageimage: json['pageimage'] as String?,
      description: json['description'] as String?,
      extract: json['extract'] as String?,
    );

Map<String, dynamic> _$WikiDescriptionModelToJson(
        WikiDescriptionModel instance) =>
    <String, dynamic>{
      'pageid': instance.pageid,
      'ns': instance.ns,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'pageimage': instance.pageimage,
      'description': instance.description,
      'extract': instance.extract,
    };
