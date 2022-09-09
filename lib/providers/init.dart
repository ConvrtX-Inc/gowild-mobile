import 'package:gowild/providers/auth.dart';
import 'package:gowild/providers/dio_client.dart';
import 'package:gowild/providers/landing_page_provider.dart';
import 'package:gowild/providers/notification.dart';
import 'package:gowild/services/logging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final initProvider = FutureProvider<void>((ref) async {
  await Hive.initFlutter();
  logger.i('Hive done.');

  await ref.read(notificationProvider).init();
  logger.i('Notification done.');

  final authProviderNotifier = ref.read(authProvider.notifier);
  final status = await authProviderNotifier.init();
  logger.i('Auth done [$status]');

  await ref.read(dioProvider.notifier).init(authProviderNotifier);
  logger.i('Dio done');

  await ref.read(hasSeenLandingPageProvider).init();
  logger.i('Landing page init');
});
