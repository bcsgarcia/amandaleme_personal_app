import 'package:intl/intl.dart';
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

  Future<void> clear() async {
    try {
      await localStorage.clear();
    } catch (error) {
      print(error);
    }
  }

  Future<void> firstTimeLogin() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await save(key: 'first_time_login', value: today);
  }

  Future<void> removeFirstTimeLogin() async {
    await delete('first_time_login');
  }

  Future<bool> isFirsTimeLoginSet() async {
    String? isFirstTimeLoginSet = localStorage.getString('first_time_login');

    return isFirstTimeLoginSet != null;
  }
}
