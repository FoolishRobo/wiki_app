abstract class CustomCache {
  Future<void> saveData(String key, dynamic data);
  Future<dynamic> getData(String key);
  Future<bool> isDataCached(String key);
  Future<void> deleteData(String key);
  Future<void> deleteAllData();
}
