import 'package:dio/dio.dart';
import 'package:gowild/helper/app_double_serializer.dart';
import 'package:gowild/providers/dio_client.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GowildApi buildGowildApi(Dio dio) {
  final s = standardSerializers.toBuilder()..add(AppDoubleSerializer());
  final api = GowildApi(
    dio: dio,
    serializers: s.build(),
  );
  return api;
}

final gowildApiProvider =
    StateNotifierProvider<GoWildApiState, GowildApi>((ref) {
  final dio = ref.watch(dioProvider);
  return GoWildApiState(dio);
});

class GoWildApiState extends StateNotifier<GowildApi> {
  final Dio dio;

  GoWildApiState(this.dio) : super(buildGowildApi(dio)) {
    _init();
  }

  void _init() async {
    state = buildGowildApi(dio);
  }
}
