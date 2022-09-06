//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/share.dart';
import 'package:gowild_api/src/model/get_many_share_response_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_share_controller_share200_response.g.dart';

/// GetManyBaseShareControllerShare200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseShareControllerShare200Response implements Built<GetManyBaseShareControllerShare200Response, GetManyBaseShareControllerShare200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<Share> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseShareControllerShare200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseShareControllerShare200ResponseBuilder b) => b;

    factory GetManyBaseShareControllerShare200Response([void updates(GetManyBaseShareControllerShare200ResponseBuilder b)]) = _$GetManyBaseShareControllerShare200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseShareControllerShare200Response> get serializer => _$GetManyBaseShareControllerShare200ResponseSerializer();
}

class _$GetManyBaseShareControllerShare200ResponseSerializer implements StructuredSerializer<GetManyBaseShareControllerShare200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseShareControllerShare200Response, _$GetManyBaseShareControllerShare200Response];

    @override
    final String wireName = r'GetManyBaseShareControllerShare200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseShareControllerShare200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(Share)])));
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
    GetManyBaseShareControllerShare200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseShareControllerShare200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Share)])) as BuiltList<Share>;
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

