import 'package:gowild/providers/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const kSeenLandingPage = 'seen_landing_page';
const kHasSeenLandingPageKey = 'has_seen_landing_page';

class NewInAppProvider {
  final HiveProvider<String> hiveProvider;

  NewInAppProvider(this.hiveProvider);

  bool get hasSeenLandingPage => hiveProvider.value(kHasSeenLandingPageKey) == 'yes';

  set hasSeenLandingPage(bool seen) {
    hiveProvider.setValue(kHasSeenLandingPageKey, seen ? 'yes' : 'no');
  }

  Future<void> init() async {
    await hiveProvider.init(kSeenLandingPage);
  }
}

final hasSeenLandingPageProvider = Provider(
  (ref) {
    final hive = ref.read(hiveProvider(kSeenLandingPage));
    return NewInAppProvider(hive);
  },
);
