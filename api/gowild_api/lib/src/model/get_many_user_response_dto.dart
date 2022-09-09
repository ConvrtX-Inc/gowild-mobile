//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_user_response_dto.g.dart';

/// GetManyUserResponseDto
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyUserResponseDto implements Built<GetManyUserResponseDto, GetManyUserResponseDtoBuilder> {
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

    GetManyUserResponseDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyUserResponseDtoBuilder b) => b;

    factory GetManyUserResponseDto([void updates(GetManyUserResponseDtoBuilder b)]) = _$GetManyUserResponseDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyUserResponseDto> get serializer => _$GetManyUserResponseDtoSerializer();
}

class _$GetManyUserResponseDtoSerializer implements StructuredSerializer<GetManyUserResponseDto> {
    @override
    final Iterable<Type> types = const [GetManyUserResponseDto, _$GetManyUserResponseDto];

    @override
    final String wireName = r'GetManyUserResponseDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyUserResponseDto object,
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
    GetManyUserResponseDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyUserResponseDtoBuilder();

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
