import 'package:gowild/providers/auth.dart';
import 'package:gowild/helper/logging.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentUserProvider = Provider((ref) {
  final auth = ref.watch(authProvider);
  final decoded = auth.decoded;
  logger.d('Getting user $decoded');
  return decoded == null ? null : _toUser(decoded['user']);
});

SimpleUser _toUser(dynamic m) {
  final builder = SimpleUserBuilder();
  builder.firstName = m['firstName'];
  builder.lastName = m['lastName'];
  builder.birthDate =
      m['birthDate'] != null ? DateTime.parse(m['birthDate']) : null;
  builder.gender = m['gender'];
  builder.username = m['username'];
  builder.phoneNo = m['phoneNo'];
  builder.email = m['email'];
  builder.fullName = m['fullName'];
  builder.picture = m['picture'];
  return builder.build();
}
