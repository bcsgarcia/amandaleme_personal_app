import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache/cache.dart';

class LocalStorageAdapter implements CacheStorage {
  final SharedPreferences localStorage;

  LocalStorageAdapter({required this.localStorage});

  @override
  Future<void> save({required String key, required dynamic value}) async {
    await localStorage.remove(key);
    await localStorage.setString(key, value);
  }

  @override
  Future<void> delete(String key) async {
    await localStorage.remove(key);
  }

  @override
  dynamic fetch(String key) {
    return localStorage.get(key);
  }

  @override
  Future<void> clear() async {
    try {
      await localStorage.clear();
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
    }
  }

  @override
  Future<void> firstTimeLogin() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await save(key: 'first_time_login', value: today);
  }

  @override
  Future<void> removeFirstTimeLogin() async {
    await delete('first_time_login');
  }

  @override
  Future<bool> isFirsTimeLoginSet() async {
    String? isFirstTimeLoginSet = localStorage.getString('first_time_login');

    return isFirstTimeLoginSet != null;
  }
}
