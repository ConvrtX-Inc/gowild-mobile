//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/get_many_user_response_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_users_controller_user200_response.g.dart';

/// GetManyBaseUsersControllerUser200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseUsersControllerUser200Response implements Built<GetManyBaseUsersControllerUser200Response, GetManyBaseUsersControllerUser200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<User> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseUsersControllerUser200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseUsersControllerUser200ResponseBuilder b) => b;

    factory GetManyBaseUsersControllerUser200Response([void updates(GetManyBaseUsersControllerUser200ResponseBuilder b)]) = _$GetManyBaseUsersControllerUser200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseUsersControllerUser200Response> get serializer => _$GetManyBaseUsersControllerUser200ResponseSerializer();
}

class _$GetManyBaseUsersControllerUser200ResponseSerializer implements StructuredSerializer<GetManyBaseUsersControllerUser200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseUsersControllerUser200Response, _$GetManyBaseUsersControllerUser200Response];

    @override
    final String wireName = r'GetManyBaseUsersControllerUser200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseUsersControllerUser200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(User)])));
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
    GetManyBaseUsersControllerUser200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseUsersControllerUser200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(User)])) as BuiltList<User>;
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

