import 'package:either_dart/either.dart';
import 'package:wiki_app/modules/wiki_description_module/models/wiki_description_model.dart';
import 'package:wiki_app/services/api_service/api_service.dart';
import 'package:wiki_app/services/error_service/custom_error.dart';
import 'package:wiki_app/services/hive_service/hive_service.dart';
import 'package:wiki_app/services/hive_service/hive_utils.dart';
import 'package:wiki_app/utils/constants.dart';

class WikiDescriptionRepo {
  List<String> getAllBookMark() {
    List<String> bookmarkList = HiveService.instance.getData(HiveUtils.wikiSearchBox, 'bookmark') ?? [];
    return bookmarkList;
  }

  Future<bool> isBookMarkAdded(String wikiId) async {
    List<String> bookmarkList = await HiveService.instance.getData(HiveUtils.wikiSearchBox, 'bookmark') ?? [];
    return bookmarkList.contains(wikiId);
  }

  Future<void> removeBookMark(String wikiId) async {
    List<String> bookmarkList = await HiveService.instance.getData(HiveUtils.wikiSearchBox, 'bookmark') ?? [];
    bookmarkList.remove(wikiId);
    await HiveService.instance.saveData(HiveUtils.wikiSearchBox, 'bookmark', bookmarkList);
  }

  Future<void> addBookMark(String wikiId) async {
    List<String> bookmarkList = await HiveService.instance.getData(HiveUtils.wikiSearchBox, 'bookmark') ?? [];
    bookmarkList.add(wikiId);
    await HiveService.instance.saveData(HiveUtils.wikiSearchBox, 'bookmark', bookmarkList);
  }
}
