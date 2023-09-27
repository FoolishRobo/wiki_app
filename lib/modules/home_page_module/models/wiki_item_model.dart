import 'package:json_annotation/json_annotation.dart';

part 'wiki_item_model.g.dart';

//TODO: might create another class which is
List<WikiItemModel> getListFromJson(Map<String, dynamic> resp) {
  List<WikiItemModel> wikiItemList = [];
  resp['query']?['pages'].forEach((element) {
    wikiItemList.add(WikiItemModel.fromJson(element));
  });
  return wikiItemList;
}

@JsonSerializable()
class WikiItemModel {
  const WikiItemModel({
    required this.pageid,
    this.title,
    this.thumbnail,
    this.description,
  });

  final int pageid;
  final String? title;
  final Thumbnail? thumbnail;
  final String? description;

  factory WikiItemModel.fromJson(Map<String, dynamic> json) => _$WikiItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$WikiItemModelToJson(this);
}

@JsonSerializable()
class Thumbnail {
  String? source;

  Thumbnail(this.source);

  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
