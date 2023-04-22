import 'package:cache_adapter/cache_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheStorageFactory {
  static Future<CacheStorage> makeLocalStorageAdapter() async {
    final localStorage = await SharedPreferences.getInstance();
    return LocalStorageAdapter(localStorage: localStorage);
  }
}
