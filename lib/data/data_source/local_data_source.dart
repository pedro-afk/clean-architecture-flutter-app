import 'package:complete_advanced_flutter/data/network/error_handler.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';

const cacheHomeKey = "cacheHomeKey";
const cacheStoreDetailKey = "cacheStoreDetailKey";
const cacheInterval = 60*1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<StoreDetailResponse> getStoreDetail();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  Future<void> saveStoreDetailToCache(StoreDetailResponse storeDetailResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
  Map<String, CachedItem> cacheMap = <String, CachedItem>{};

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];
    if (cachedItem != null && cachedItem.isValid(cacheInterval)) {
      return cachedItem.data;
    }
    throw ErrorHandler.handler(DataSource.cacheError);
  }

  @override
  Future<StoreDetailResponse> getStoreDetail() {
    CachedItem? cachedItem = cacheMap[cacheStoreDetailKey];
    if (cachedItem != null && cachedItem.isValid(cacheInterval)) {
      return cachedItem.data;
    }
    throw ErrorHandler.handler(DataSource.cacheError);
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<void> saveStoreDetailToCache(StoreDetailResponse storeDetailResponse) async {
    cacheMap[cacheStoreDetailKey] = CachedItem(storeDetailResponse);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}
extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = currentTimeInMillis - expirationTime < cacheTime;
    return isCacheValid;
  }
}