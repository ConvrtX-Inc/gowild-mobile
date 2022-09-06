//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/get_many_comment_response_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/comment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_comment_controller_comment200_response.g.dart';

/// GetManyBaseCommentControllerComment200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseCommentControllerComment200Response implements Built<GetManyBaseCommentControllerComment200Response, GetManyBaseCommentControllerComment200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<Comment> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseCommentControllerComment200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseCommentControllerComment200ResponseBuilder b) => b;

    factory GetManyBaseCommentControllerComment200Response([void updates(GetManyBaseCommentControllerComment200ResponseBuilder b)]) = _$GetManyBaseCommentControllerComment200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseCommentControllerComment200Response> get serializer => _$GetManyBaseCommentControllerComment200ResponseSerializer();
}

class _$GetManyBaseCommentControllerComment200ResponseSerializer implements StructuredSerializer<GetManyBaseCommentControllerComment200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseCommentControllerComment200Response, _$GetManyBaseCommentControllerComment200Response];

    @override
    final String wireName = r'GetManyBaseCommentControllerComment200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseCommentControllerComment200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(Comment)])));
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
    GetManyBaseCommentControllerComment200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseCommentControllerComment200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Comment)])) as BuiltList<Comment>;
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

