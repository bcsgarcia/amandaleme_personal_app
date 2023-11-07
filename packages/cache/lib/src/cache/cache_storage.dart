abstract class CacheStorage {
  dynamic fetch(String key);
  Future<void> delete(String key);
  Future<void> save({required String key, required dynamic value});
  Future<void> clear();
  Future<void> firstTimeLogin();
  Future<void> removeFirstTimeLogin();
  Future<bool> isFirsTimeLoginSet();
}
