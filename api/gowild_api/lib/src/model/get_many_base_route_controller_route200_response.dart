//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/get_many_route_response_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_route_controller_route200_response.g.dart';

/// GetManyBaseRouteControllerRoute200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseRouteControllerRoute200Response implements Built<GetManyBaseRouteControllerRoute200Response, GetManyBaseRouteControllerRoute200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<Route> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseRouteControllerRoute200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseRouteControllerRoute200ResponseBuilder b) => b;

    factory GetManyBaseRouteControllerRoute200Response([void updates(GetManyBaseRouteControllerRoute200ResponseBuilder b)]) = _$GetManyBaseRouteControllerRoute200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseRouteControllerRoute200Response> get serializer => _$GetManyBaseRouteControllerRoute200ResponseSerializer();
}

class _$GetManyBaseRouteControllerRoute200ResponseSerializer implements StructuredSerializer<GetManyBaseRouteControllerRoute200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseRouteControllerRoute200Response, _$GetManyBaseRouteControllerRoute200Response];

    @override
    final String wireName = r'GetManyBaseRouteControllerRoute200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseRouteControllerRoute200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(Route)])));
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
    GetManyBaseRouteControllerRoute200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseRouteControllerRoute200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Route)])) as BuiltList<Route>;
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

