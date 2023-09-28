// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListOfWikiItemModelAdapter extends TypeAdapter<ListOfWikiItemModel> {
  @override
  final int typeId = 0;

  @override
  ListOfWikiItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListOfWikiItemModel(
      (fields[0] as List).cast<WikiItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListOfWikiItemModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.wikiItemList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListOfWikiItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WikiItemModelAdapter extends TypeAdapter<WikiItemModel> {
  @override
  final int typeId = 1;

  @override
  WikiItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WikiItemModel(
      pageid: fields[0] as int,
      title: fields[1] as String?,
      thumbnail: fields[2] as Thumbnail?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WikiItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.pageid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.thumbnail)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WikiItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThumbnailAdapter extends TypeAdapter<Thumbnail> {
  @override
  final int typeId = 2;

  @override
  Thumbnail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Thumbnail(
      fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Thumbnail obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThumbnailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListOfWikiItemModel _$ListOfWikiItemModelFromJson(Map<String, dynamic> json) =>
    ListOfWikiItemModel(
      (json['pages'] as List<dynamic>)
          .map((e) => WikiItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListOfWikiItemModelToJson(
        ListOfWikiItemModel instance) =>
    <String, dynamic>{
      'pages': instance.wikiItemList.map((e) => e.toJson()).toList(),
    };

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
      'thumbnail': instance.thumbnail?.toJson(),
      'description': instance.description,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      json['source'] as String?,
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'source': instance.source,
    };
