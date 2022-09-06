//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/get_many_room_response_dto.dart';
import 'package:gowild_api/src/model/room.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_room_controller_room200_response.g.dart';

/// GetManyBaseRoomControllerRoom200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseRoomControllerRoom200Response implements Built<GetManyBaseRoomControllerRoom200Response, GetManyBaseRoomControllerRoom200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<Room> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseRoomControllerRoom200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseRoomControllerRoom200ResponseBuilder b) => b;

    factory GetManyBaseRoomControllerRoom200Response([void updates(GetManyBaseRoomControllerRoom200ResponseBuilder b)]) = _$GetManyBaseRoomControllerRoom200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseRoomControllerRoom200Response> get serializer => _$GetManyBaseRoomControllerRoom200ResponseSerializer();
}

class _$GetManyBaseRoomControllerRoom200ResponseSerializer implements StructuredSerializer<GetManyBaseRoomControllerRoom200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseRoomControllerRoom200Response, _$GetManyBaseRoomControllerRoom200Response];

    @override
    final String wireName = r'GetManyBaseRoomControllerRoom200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseRoomControllerRoom200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(Room)])));
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
    GetManyBaseRoomControllerRoom200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseRoomControllerRoom200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Room)])) as BuiltList<Room>;
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

