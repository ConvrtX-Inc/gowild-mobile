//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'guideline.g.dart';

/// Guideline
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [type] 
/// * [description] 
/// * [lastUpdatedUser] 
abstract class Guideline implements Built<Guideline, GuidelineBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'type')
    String get type;

    @BuiltValueField(wireName: r'description')
    String get description;

    @BuiltValueField(wireName: r'last_updated_user')
    String get lastUpdatedUser;

    Guideline._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GuidelineBuilder b) => b;

    factory Guideline([void updates(GuidelineBuilder b)]) = _$Guideline;

    @BuiltValueSerializer(custom: true)
    static Serializer<Guideline> get serializer => _$GuidelineSerializer();
}

class _$GuidelineSerializer implements StructuredSerializer<Guideline> {
    @override
    final Iterable<Type> types = const [Guideline, _$Guideline];

    @override
    final String wireName = r'Guideline';

    @override
    Iterable<Object?> serialize(Serializers serializers, Guideline object,
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
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        result
            ..add(r'last_updated_user')
            ..add(serializers.serialize(object.lastUpdatedUser,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Guideline deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GuidelineBuilder();

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
                case r'type':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.type = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'last_updated_user':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.lastUpdatedUser = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

