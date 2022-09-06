//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'comment.g.dart';

/// Comment
///
/// Properties:
/// * [userId] 
/// * [postfeedId] 
/// * [message] 
abstract class Comment implements Built<Comment, CommentBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'postfeed_id')
    String get postfeedId;

    @BuiltValueField(wireName: r'message')
    String get message;

    Comment._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CommentBuilder b) => b;

    factory Comment([void updates(CommentBuilder b)]) = _$Comment;

    @BuiltValueSerializer(custom: true)
    static Serializer<Comment> get serializer => _$CommentSerializer();
}

class _$CommentSerializer implements StructuredSerializer<Comment> {
    @override
    final Iterable<Type> types = const [Comment, _$Comment];

    @override
    final String wireName = r'Comment';

    @override
    Iterable<Object?> serialize(Serializers serializers, Comment object,
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
        result
            ..add(r'message')
            ..add(serializers.serialize(object.message,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Comment deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CommentBuilder();

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
                case r'message':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.message = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

