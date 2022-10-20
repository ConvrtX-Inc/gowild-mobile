import 'package:gowild/providers/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const kIsFirstTime = 'is_first_time';
const kIsFirstTimeKey = 'first_time';

class NewInAppProvider {
  final HiveProvider<String> hiveProvider;

  NewInAppProvider(this.hiveProvider);

  bool get isNewInApp => hiveProvider.value(kIsFirstTimeKey) != 'no';

  set isNewInApp(bool isFirstTime) {
    hiveProvider.setValue(kIsFirstTimeKey, isFirstTime ? 'no' : 'yes');
  }

  Future<void> init() async {
    await hiveProvider.init(kIsFirstTime);
  }
}

final isNewInAppProvider = Provider(
  (ref) {
    final hive = ref.read(hiveProvider(kIsFirstTime));
    return NewInAppProvider(hive);
  },
);
