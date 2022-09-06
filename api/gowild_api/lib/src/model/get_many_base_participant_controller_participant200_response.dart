//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/participant.dart';
import 'package:gowild_api/src/model/get_many_participant_response_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_participant_controller_participant200_response.g.dart';

/// GetManyBaseParticipantControllerParticipant200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseParticipantControllerParticipant200Response implements Built<GetManyBaseParticipantControllerParticipant200Response, GetManyBaseParticipantControllerParticipant200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<Participant> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseParticipantControllerParticipant200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseParticipantControllerParticipant200ResponseBuilder b) => b;

    factory GetManyBaseParticipantControllerParticipant200Response([void updates(GetManyBaseParticipantControllerParticipant200ResponseBuilder b)]) = _$GetManyBaseParticipantControllerParticipant200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseParticipantControllerParticipant200Response> get serializer => _$GetManyBaseParticipantControllerParticipant200ResponseSerializer();
}

class _$GetManyBaseParticipantControllerParticipant200ResponseSerializer implements StructuredSerializer<GetManyBaseParticipantControllerParticipant200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseParticipantControllerParticipant200Response, _$GetManyBaseParticipantControllerParticipant200Response];

    @override
    final String wireName = r'GetManyBaseParticipantControllerParticipant200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseParticipantControllerParticipant200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(Participant)])));
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
    GetManyBaseParticipantControllerParticipant200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseParticipantControllerParticipant200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Participant)])) as BuiltList<Participant>;
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

