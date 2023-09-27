import 'package:wiki_app/modules/home_page_module/models/wiki_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wiki_description_model.g.dart';

@JsonSerializable()
class WikiDescriptionModel {
  int? pageid;
  int? ns;
  String? title;
  Thumbnail? thumbnail;
  String? pageimage;
  String? description;
  String? extract;

  WikiDescriptionModel({this.pageid, this.ns, this.title, this.thumbnail, this.pageimage, this.description, this.extract});

  factory WikiDescriptionModel.fromJson(Map<String, dynamic> json) => _$WikiDescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WikiDescriptionModelToJson(this);
}
