//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_controller_check200_response_info_value.g.dart';

/// HealthControllerCheck200ResponseInfoValue
///
/// Properties:
/// * [status] 
abstract class HealthControllerCheck200ResponseInfoValue implements Built<HealthControllerCheck200ResponseInfoValue, HealthControllerCheck200ResponseInfoValueBuilder> {
    @BuiltValueField(wireName: r'status')
    String? get status;

    HealthControllerCheck200ResponseInfoValue._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(HealthControllerCheck200ResponseInfoValueBuilder b) => b;

    factory HealthControllerCheck200ResponseInfoValue([void updates(HealthControllerCheck200ResponseInfoValueBuilder b)]) = _$HealthControllerCheck200ResponseInfoValue;

    @BuiltValueSerializer(custom: true)
    static Serializer<HealthControllerCheck200ResponseInfoValue> get serializer => _$HealthControllerCheck200ResponseInfoValueSerializer();
}

class _$HealthControllerCheck200ResponseInfoValueSerializer implements StructuredSerializer<HealthControllerCheck200ResponseInfoValue> {
    @override
    final Iterable<Type> types = const [HealthControllerCheck200ResponseInfoValue, _$HealthControllerCheck200ResponseInfoValue];

    @override
    final String wireName = r'HealthControllerCheck200ResponseInfoValue';

    @override
    Iterable<Object?> serialize(Serializers serializers, HealthControllerCheck200ResponseInfoValue object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.status != null) {
            result
                ..add(r'status')
                ..add(serializers.serialize(object.status,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    HealthControllerCheck200ResponseInfoValue deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = HealthControllerCheck200ResponseInfoValueBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'status':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.status = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

