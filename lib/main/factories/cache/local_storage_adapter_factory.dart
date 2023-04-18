import 'package:cache_adapter/cache_adapter.dart';
import 'package:localstorage/localstorage.dart';

CacheStorage makeLocalStorageAdapter() =>
    LocalStorageAdapter(localStorage: LocalStorage('amandalemeApp'));
