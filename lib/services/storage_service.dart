/// Simple in-memory key/value storage.
///
/// UI only project - this deliberately avoids any package such as
/// `shared_preferences`. Values live for as long as the app is running.
/// Swap the implementation for real storage later without touching the
/// screens.
class StorageService {
  StorageService._();

  static final Map<String, dynamic> _store = <String, dynamic>{};

  static void set(String key, dynamic value) {
    _store[key] = value;
  }

  static T? get<T>(String key) {
    final value = _store[key];
    if (value is T) return value;
    return null;
  }

  static String? getString(String key) => get<String>(key);

  static bool getBool(String key, {bool defaultValue = false}) {
    return get<bool>(key) ?? defaultValue;
  }

  static void remove(String key) {
    _store.remove(key);
  }

  static void clear() {
    _store.clear();
  }

  static bool containsKey(String key) => _store.containsKey(key);
}
