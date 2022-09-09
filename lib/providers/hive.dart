import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HiveProvider<T> {
  late Box<T> _box;
  bool _initCalled = false;

  Future<void> init(String boxName) async {
    if (_initCalled) {
      return;
    }

    _box = await Hive.openBox(boxName);
    _initCalled = true;
  }

  T? value(String key) {
    return _box.get(key);
  }

  void setValue(String key, T value) async {
    await _box.put(key, value);
  }

  void removeValue(String key) async {
    await _box.delete(key);
  }
}

final hiveProvider = Provider.family.autoDispose(
  (ref, String boxName) {
    final p = HiveProvider<String>();
    p.init(boxName);
    return p;
  },
);
