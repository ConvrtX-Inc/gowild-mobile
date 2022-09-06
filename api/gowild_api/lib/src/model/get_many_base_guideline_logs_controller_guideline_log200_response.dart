//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/get_many_guideline_log_response_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/guideline_log.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_guideline_logs_controller_guideline_log200_response.g.dart';

/// GetManyBaseGuidelineLogsControllerGuidelineLog200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseGuidelineLogsControllerGuidelineLog200Response implements Built<GetManyBaseGuidelineLogsControllerGuidelineLog200Response, GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<GuidelineLog> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseGuidelineLogsControllerGuidelineLog200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder b) => b;

    factory GetManyBaseGuidelineLogsControllerGuidelineLog200Response([void updates(GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder b)]) = _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseGuidelineLogsControllerGuidelineLog200Response> get serializer => _$GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseSerializer();
}

class _$GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseSerializer implements StructuredSerializer<GetManyBaseGuidelineLogsControllerGuidelineLog200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseGuidelineLogsControllerGuidelineLog200Response, _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response];

    @override
    final String wireName = r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseGuidelineLogsControllerGuidelineLog200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(GuidelineLog)])));
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
    GetManyBaseGuidelineLogsControllerGuidelineLog200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(GuidelineLog)])) as BuiltList<GuidelineLog>;
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

