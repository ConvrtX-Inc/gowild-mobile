import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HiveProvider<T> {
  late Box<T> _box;

  void _init(String boxName) async {
    _box = await Hive.openBox(boxName);
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
    p._init(boxName);
    return p;
  },
);
