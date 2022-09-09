import 'package:gowild/providers/gowild.api-client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routeApiProvider = Provider.autoDispose((ref) {
  final gowildApi = ref.watch(gowildApiProvider);
  return gowildApi.getRouteApi();
});

final routeHistoricalEventPhotoApiProvider = Provider.autoDispose((ref) {
  final gowildApi = ref.watch(gowildApiProvider);
  return gowildApi.getRouteHistoricalEventPhotoApi();
});

final routeHistoricalEventApiProvider = Provider.autoDispose((ref) {
  final gowildApi = ref.watch(gowildApiProvider);
  return gowildApi.getRouteHistoricalEventApi();
});

final routeCluesApiProvider = Provider.autoDispose((ref) {
  final gowildApi = ref.watch(gowildApiProvider);
  return gowildApi.getRouteCluesApi();
});
