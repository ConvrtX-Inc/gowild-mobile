import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gowild/environment_config.dart';
import 'package:gowild/helper/auth.dio-interceptor.dart';
import 'package:gowild/providers/auth.dart';
import 'package:gowild/services/logging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'dio_client.freezed.dart';

@freezed
class BuildDioOptions with _$BuildDioOptions {
  factory BuildDioOptions({
    required bool withCookies,
    required bool withLogger,
    required bool withCache,
    required bool withRetry,
    required String baseUrl,
  }) = _BuildDioOptions;

  static BuildDioOptions kDefault = BuildDioOptions(
    withCookies: true,
    withLogger: true,
    withCache: true,
    withRetry: true,
    baseUrl: EnvironmentConfig.apiBaseUrl,
  );
}

Future<Dio> buildDio(AuthProvider authProvider,
    [BuildDioOptions? options]) async {
  options = options ?? BuildDioOptions.kDefault;
  final dio = Dio(BaseOptions(baseUrl: options.baseUrl));

  if (!kIsWeb) {
    dio.httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: 10000,
        // Ignore bad certificate
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ),
    );
  }

  if (!kIsWeb && options.withCookies) {
    final app = await getApplicationDocumentsDirectory();
    var cookieJar = PersistCookieJar(storage: FileStorage('${app.path}/dio'));
    dio.interceptors.add(CookieManager(cookieJar));
  }
  if (options.withLogger) {
    dio.interceptors.add(PrettyDioLogger(
      compact: true,
      logPrint: (object) {
        logger.d(object);
      },
    ));
  }
  if (options.withRetry) {
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: (msg) => logger.d('Retry: $msg'), // specify log function (optional)
      retries: 3, // retry count (optional)
      retryDelays: const [
        // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));
  }
  if (options.withCache) {
    final path = await _getDioPath();
    final options = CacheOptions(
      store: HiveCacheStore(path),
    );
    dio.interceptors.add(DioCacheInterceptor(options: options));
  }

  dio.interceptors.add(AuthenticatorInterceptor(authProvider));

  return dio;
}

FutureOr<String?> _getDioPath() async {
  if (kIsWeb) {
    return null;
  }
  final dir = await getApplicationDocumentsDirectory();
  return '${dir.path}/api';
}

class DioNotifier extends StateNotifier<Dio> {
  bool _init = false;

  DioNotifier() : super(Dio());

  Future<void> init(AuthProvider authProvider) async {
    if (_init) return;

    state = await buildDio(authProvider);
    _init = true;
  }
}

final dioProvider = StateNotifierProvider<DioNotifier, Dio>((ref) {
  return DioNotifier();
});
