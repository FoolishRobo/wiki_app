import 'package:wiki_app/services/hive_service/hive_service.dart';
import 'package:wiki_app/services/hive_service/hive_utils.dart';

class WikiDescriptionRepo {
  List<String> getAllBookMark() {
    List<String> bookmarkList = HiveService.instance.getData(HiveUtils.wikiSearchBox, 'bookmark') ?? [];
    return bookmarkList;
  }

  Future<bool> isBookMarkAdded(String wikiId) async {
    List<String> bookmarkList = getAllBookMark();
    return bookmarkList.contains(wikiId);
  }

  Future<List<String>> removeBookMark(String wikiId) async {
    List<String> bookmarkList = getAllBookMark();
    bookmarkList.remove(wikiId);
    await HiveService.instance.saveData(HiveUtils.wikiSearchBox, 'bookmark', bookmarkList);
    return bookmarkList;
  }

  Future<List<String>> addBookMark(String wikiId) async {
    List<String> bookmarkList = getAllBookMark();
    bookmarkList.add(wikiId);
    await HiveService.instance.saveData(HiveUtils.wikiSearchBox, 'bookmark', bookmarkList);
    return bookmarkList;
  }
}
