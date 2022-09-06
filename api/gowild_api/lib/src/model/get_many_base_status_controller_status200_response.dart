//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/get_many_status_response_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_status_controller_status200_response.g.dart';

/// GetManyBaseStatusControllerStatus200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseStatusControllerStatus200Response implements Built<GetManyBaseStatusControllerStatus200Response, GetManyBaseStatusControllerStatus200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<Status> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseStatusControllerStatus200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseStatusControllerStatus200ResponseBuilder b) => b;

    factory GetManyBaseStatusControllerStatus200Response([void updates(GetManyBaseStatusControllerStatus200ResponseBuilder b)]) = _$GetManyBaseStatusControllerStatus200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseStatusControllerStatus200Response> get serializer => _$GetManyBaseStatusControllerStatus200ResponseSerializer();
}

class _$GetManyBaseStatusControllerStatus200ResponseSerializer implements StructuredSerializer<GetManyBaseStatusControllerStatus200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseStatusControllerStatus200Response, _$GetManyBaseStatusControllerStatus200Response];

    @override
    final String wireName = r'GetManyBaseStatusControllerStatus200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseStatusControllerStatus200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(Status)])));
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
    GetManyBaseStatusControllerStatus200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseStatusControllerStatus200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Status)])) as BuiltList<Status>;
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

