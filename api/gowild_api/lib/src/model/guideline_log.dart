//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'guideline_log.g.dart';

/// GuidelineLog
///
/// Properties:
/// * [userId] 
/// * [guidelineType] 
/// * [lastUpdateDate] 
abstract class GuidelineLog implements Built<GuidelineLog, GuidelineLogBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'guideline_type')
    String get guidelineType;

    @BuiltValueField(wireName: r'last_update_date')
    DateTime get lastUpdateDate;

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
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'guideline_type')
            ..add(serializers.serialize(object.guidelineType,
                specifiedType: const FullType(String)));
        result
            ..add(r'last_update_date')
            ..add(serializers.serialize(object.lastUpdateDate,
                specifiedType: const FullType(DateTime)));
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
                case r'user_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.userId = valueDes;
                    break;
                case r'guideline_type':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.guidelineType = valueDes;
                    break;
                case r'last_update_date':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    result.lastUpdateDate = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

