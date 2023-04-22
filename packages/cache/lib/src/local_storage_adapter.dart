import 'package:shared_preferences/shared_preferences.dart';

import 'cache/cache.dart';

class LocalStorageAdapter implements CacheStorage {
  final SharedPreferences localStorage;

  LocalStorageAdapter({required this.localStorage});

  Future<void> save({required String key, required dynamic value}) async {
    await localStorage.remove(key);
    await localStorage.setString(key, value);
  }

  Future<void> delete(String key) async {
    await localStorage.remove(key);
  }

  dynamic fetch(String key) {
    return localStorage.get(key);
  }

  @override
  Future<void> clear() async {
    await localStorage.clear();
  }
}
