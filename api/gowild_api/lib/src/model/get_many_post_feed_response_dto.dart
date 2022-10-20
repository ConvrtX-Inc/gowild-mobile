//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/post_feed.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_post_feed_response_dto.g.dart';

/// GetManyPostFeedResponseDto
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyPostFeedResponseDto implements Built<GetManyPostFeedResponseDto, GetManyPostFeedResponseDtoBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<PostFeed> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyPostFeedResponseDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyPostFeedResponseDtoBuilder b) => b;

    factory GetManyPostFeedResponseDto([void updates(GetManyPostFeedResponseDtoBuilder b)]) = _$GetManyPostFeedResponseDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyPostFeedResponseDto> get serializer => _$GetManyPostFeedResponseDtoSerializer();
}

class _$GetManyPostFeedResponseDtoSerializer implements StructuredSerializer<GetManyPostFeedResponseDto> {
    @override
    final Iterable<Type> types = const [GetManyPostFeedResponseDto, _$GetManyPostFeedResponseDto];

    @override
    final String wireName = r'GetManyPostFeedResponseDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyPostFeedResponseDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(PostFeed)])));
        result
            ..add(r'count')
            ..add(serializers.serialize(object.count,
                specifiedType: const FullType(num)));
        result
            ..add(r'total')
            ..add(serializers.serialize(object.total,
                specifiedType: const FullType(num)));
        result
            ..add(r'page')
            ..add(serializers.serialize(object.page,
                specifiedType: const FullType(num)));
        result
            ..add(r'pageCount')
            ..add(serializers.serialize(object.pageCount,
                specifiedType: const FullType(num)));
        return result;
    }

    @override
    GetManyPostFeedResponseDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyPostFeedResponseDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(PostFeed)])) as BuiltList<PostFeed>;
                    result.data.replace(valueDes);
                    break;
                case r'count':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.count = valueDes;
                    break;
                case r'total':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.total = valueDes;
                    break;
                case r'page':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.page = valueDes;
                    break;
                case r'pageCount':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.pageCount = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

