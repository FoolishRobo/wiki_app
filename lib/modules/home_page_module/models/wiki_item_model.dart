import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wiki_item_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class ListOfWikiItemModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'pages')
  List<WikiItemModel> wikiItemList;

  ListOfWikiItemModel(this.wikiItemList);

  factory ListOfWikiItemModel.fromJson(Map<String, dynamic> json) => _$ListOfWikiItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListOfWikiItemModelToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
@JsonSerializable(explicitToJson: true)
class WikiItemModel extends HiveObject {
  WikiItemModel({
    required this.pageid,
    this.title,
    this.thumbnail,
    this.description,
  });
  @HiveField(0)
  final int pageid;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final Thumbnail? thumbnail;
  @HiveField(3)
  final String? description;

  factory WikiItemModel.fromJson(Map<String, dynamic> json) => _$WikiItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$WikiItemModelToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
@JsonSerializable()
class Thumbnail extends HiveObject {
  @HiveField(0)
  String? source;

  Thumbnail(this.source);

  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
