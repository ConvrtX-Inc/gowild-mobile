import 'package:built_value/serializer.dart';
import 'package:built_value/src/double_serializer.dart';

class AppDoubleSerializer extends DoubleSerializer {
  @override
  double deserialize(Serializers serializers, Object? serialized,
      {FullType specifiedType = FullType.unspecified}) {
    if (serialized is String) {
      final value = num.tryParse(serialized)?.toDouble();
      if (value != null) {
        return value;
      }
    }
    return super.deserialize(serializers, serialized);
  }
}
