//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'like.g.dart';

/// Like
///
/// Properties:
/// * [userId] 
/// * [postfeedId] 
abstract class Like implements Built<Like, LikeBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'postfeed_id')
    String get postfeedId;

    Like._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(LikeBuilder b) => b;

    factory Like([void updates(LikeBuilder b)]) = _$Like;

    @BuiltValueSerializer(custom: true)
    static Serializer<Like> get serializer => _$LikeSerializer();
}

class _$LikeSerializer implements StructuredSerializer<Like> {
    @override
    final Iterable<Type> types = const [Like, _$Like];

    @override
    final String wireName = r'Like';

    @override
    Iterable<Object?> serialize(Serializers serializers, Like object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'postfeed_id')
            ..add(serializers.serialize(object.postfeedId,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Like deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = LikeBuilder();

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
                case r'postfeed_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.postfeedId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

