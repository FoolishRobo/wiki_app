import 'package:hive/hive.dart';
import 'package:wiki_app/modules/home_page_module/models/wiki_item_model.dart';

class HiveUtils {
  static String wikiSearchBox = 'wiki_app';

  //hive object adapterId
  final wikiItemListAdapterId = 1;
  final wikiItemModelAdapterId = 2;
  final thumbnailAdapterId = 3;

  //register hive adapter
  static void ensureInitialized() {
    Hive.registerAdapter(WikiItemModelAdapter());
    Hive.registerAdapter(ListOfWikiItemModelAdapter());
    Hive.registerAdapter(ThumbnailAdapter());
  }
}
