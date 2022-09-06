//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'post_feed.g.dart';

/// PostFeed
///
/// Properties:
/// * [userId] 
/// * [title] 
/// * [description] 
/// * [img] 
/// * [isPublished] 
/// * [views] 
abstract class PostFeed implements Built<PostFeed, PostFeedBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'title')
    String get title;

    @BuiltValueField(wireName: r'description')
    String get description;

    @BuiltValueField(wireName: r'img')
    JsonObject get img;

    @BuiltValueField(wireName: r'is_published')
    bool get isPublished;

    @BuiltValueField(wireName: r'views')
    num get views;

    PostFeed._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PostFeedBuilder b) => b;

    factory PostFeed([void updates(PostFeedBuilder b)]) = _$PostFeed;

    @BuiltValueSerializer(custom: true)
    static Serializer<PostFeed> get serializer => _$PostFeedSerializer();
}

class _$PostFeedSerializer implements StructuredSerializer<PostFeed> {
    @override
    final Iterable<Type> types = const [PostFeed, _$PostFeed];

    @override
    final String wireName = r'PostFeed';

    @override
    Iterable<Object?> serialize(Serializers serializers, PostFeed object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'title')
            ..add(serializers.serialize(object.title,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        result
            ..add(r'img')
            ..add(serializers.serialize(object.img,
                specifiedType: const FullType(JsonObject)));
        result
            ..add(r'is_published')
            ..add(serializers.serialize(object.isPublished,
                specifiedType: const FullType(bool)));
        result
            ..add(r'views')
            ..add(serializers.serialize(object.views,
                specifiedType: const FullType(num)));
        return result;
    }

    @override
    PostFeed deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PostFeedBuilder();

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
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.title = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'img':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(JsonObject)) as JsonObject;
                    result.img = valueDes;
                    break;
                case r'is_published':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.isPublished = valueDes;
                    break;
                case r'views':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.views = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

