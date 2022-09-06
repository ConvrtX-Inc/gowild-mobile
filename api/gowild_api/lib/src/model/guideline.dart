//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'guideline.g.dart';

/// Guideline
///
/// Properties:
/// * [type] 
/// * [description] 
/// * [lastUpdatedUser] 
abstract class Guideline implements Built<Guideline, GuidelineBuilder> {
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

