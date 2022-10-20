//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'guideline_log.g.dart';

/// GuidelineLog
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [userId] 
/// * [guidelineType] 
abstract class GuidelineLog implements Built<GuidelineLog, GuidelineLogBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'userId')
    String get userId;

    @BuiltValueField(wireName: r'guideline_type')
    String get guidelineType;

    GuidelineLog._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GuidelineLogBuilder b) => b;

    factory GuidelineLog([void updates(GuidelineLogBuilder b)]) = _$GuidelineLog;

    @BuiltValueSerializer(custom: true)
    static Serializer<GuidelineLog> get serializer => _$GuidelineLogSerializer();
}

class _$GuidelineLogSerializer implements StructuredSerializer<GuidelineLog> {
    @override
    final Iterable<Type> types = const [GuidelineLog, _$GuidelineLog];

    @override
    final String wireName = r'GuidelineLog';

    @override
    Iterable<Object?> serialize(Serializers serializers, GuidelineLog object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'createdDate')
            ..add(object.createdDate == null ? null : serializers.serialize(object.createdDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'updatedDate')
            ..add(object.updatedDate == null ? null : serializers.serialize(object.updatedDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'userId')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'guideline_type')
            ..add(serializers.serialize(object.guidelineType,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    GuidelineLog deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GuidelineLogBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.id = valueDes;
                    break;
                case r'createdDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.createdDate = valueDes;
                    break;
                case r'updatedDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.updatedDate = valueDes;
                    break;
                case r'userId':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.userId = valueDes;
                    break;
                case r'guideline_type':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.guidelineType = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

