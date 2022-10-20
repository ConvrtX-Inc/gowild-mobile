import 'package:gowild/providers/auth.dart';
import 'package:gowild/providers/dio_client.dart';
import 'package:gowild/providers/landing_page_provider.dart';
import 'package:gowild/providers/map_settings_provider.dart';
import 'package:gowild/providers/notification.dart';
import 'package:gowild/helper/logging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final initProvider = FutureProvider<void>((ref) async {
  await Hive.initFlutter();
  logger.i('Hive storage init');

  await ref.read(notificationProvider).init();
  logger.i('Notification init');

  final authProviderNotifier = ref.read(authProvider.notifier);
  final status = await authProviderNotifier.init();
  logger.i('Auth done [$status] init');

  await ref.read(dioProvider.notifier).init(authProviderNotifier);
  logger.i('GoWild-Dio client init');

  await ref.read(hasSeenLandingPageProvider).init();
  logger.i('Landing page init');

  await ref.read(mapSettingsProvider.notifier).init();
  logger.i('Map settings init');
});
