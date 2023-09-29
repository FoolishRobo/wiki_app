import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wiki_app/services/hive_service/hive_utils.dart';

class HiveService {
  late Box box;

  HiveService._();

  static final HiveService _instance = HiveService._();

  static HiveService get instance => _instance;

  init(String boxName) async {
    Hive.initFlutter();
    HiveUtils.ensureInitialized();
    await openBox(boxName);
  }

  Future<Box> openBox(String boxName) async {
    if (!kIsWeb && !Hive.isBoxOpen(boxName)) Hive.init((await getApplicationDocumentsDirectory()).path);
    box = await Hive.openBox(boxName);
    return box;
  }

  saveData(String boxName, String key, dynamic data, {bool isPaginatedApi = false}) {
    // if (!Hive.isBoxOpen(boxName)) await openBox(boxName);
    //if it is a paginated api, then we will not clear the previous data
    if (!isPaginatedApi) {
      box.delete(key.toLowerCase());
    }
    box.put(key.toLowerCase(), data);
  }

  dynamic getData(String boxName, String key) {
    // if (!Hive.isBoxOpen(boxName)) await openBox(boxName);
    return box.get(key.toLowerCase());
  }

  bool isDataCached(String boxName, String key) {
    // if (!Hive.isBoxOpen(boxName)) await openBox(boxName);
    return box.keys.contains(key.toLowerCase());
  }

  deleteData(String boxName, String key) async {
    // if (!Hive.isBoxOpen(boxName)) await openBox(boxName);
    box.delete(key.toLowerCase());
  }

  deleteBox(String boxName) {
    Hive.deleteBoxFromDisk(boxName);
  }

  deleteAllBoxes() {
    Hive.deleteFromDisk();
  }
}
