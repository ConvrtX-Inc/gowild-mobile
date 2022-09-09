//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/health_controller_check200_response_info_value.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_controller_check200_response.g.dart';

/// HealthControllerCheck200Response
///
/// Properties:
/// * [status] 
/// * [info] 
/// * [error] 
/// * [details] 
abstract class HealthControllerCheck200Response implements Built<HealthControllerCheck200Response, HealthControllerCheck200ResponseBuilder> {
    @BuiltValueField(wireName: r'status')
    String? get status;

    @BuiltValueField(wireName: r'info')
    BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? get info;

    @BuiltValueField(wireName: r'error')
    BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? get error;

    @BuiltValueField(wireName: r'details')
    BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? get details;

    HealthControllerCheck200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(HealthControllerCheck200ResponseBuilder b) => b;

    factory HealthControllerCheck200Response([void updates(HealthControllerCheck200ResponseBuilder b)]) = _$HealthControllerCheck200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<HealthControllerCheck200Response> get serializer => _$HealthControllerCheck200ResponseSerializer();
}

class _$HealthControllerCheck200ResponseSerializer implements StructuredSerializer<HealthControllerCheck200Response> {
    @override
    final Iterable<Type> types = const [HealthControllerCheck200Response, _$HealthControllerCheck200Response];

    @override
    final String wireName = r'HealthControllerCheck200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, HealthControllerCheck200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.status != null) {
            result
                ..add(r'status')
                ..add(serializers.serialize(object.status,
                    specifiedType: const FullType(String)));
        }
        if (object.info != null) {
            result
                ..add(r'info')
                ..add(serializers.serialize(object.info,
                    specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)])));
        }
        if (object.error != null) {
            result
                ..add(r'error')
                ..add(serializers.serialize(object.error,
                    specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)])));
        }
        if (object.details != null) {
            result
                ..add(r'details')
                ..add(serializers.serialize(object.details,
                    specifiedType: const FullType(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)])));
        }
        return result;
    }

    @override
    HealthControllerCheck200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = HealthControllerCheck200ResponseBuilder();

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
                case r'info':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)])) as BuiltMap<String, HealthControllerCheck200ResponseInfoValue>?;
                    if (valueDes == null) continue;
                    result.info.replace(valueDes);
                    break;
                case r'error':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)])) as BuiltMap<String, HealthControllerCheck200ResponseInfoValue>?;
                    if (valueDes == null) continue;
                    result.error.replace(valueDes);
                    break;
                case r'details':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(HealthControllerCheck200ResponseInfoValue)])) as BuiltMap<String, HealthControllerCheck200ResponseInfoValue>;
                    result.details.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

