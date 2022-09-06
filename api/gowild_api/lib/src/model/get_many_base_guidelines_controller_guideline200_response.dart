//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/guideline.dart';
import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/get_many_guideline_response_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_guidelines_controller_guideline200_response.g.dart';

/// GetManyBaseGuidelinesControllerGuideline200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseGuidelinesControllerGuideline200Response implements Built<GetManyBaseGuidelinesControllerGuideline200Response, GetManyBaseGuidelinesControllerGuideline200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<Guideline> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseGuidelinesControllerGuideline200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseGuidelinesControllerGuideline200ResponseBuilder b) => b;

    factory GetManyBaseGuidelinesControllerGuideline200Response([void updates(GetManyBaseGuidelinesControllerGuideline200ResponseBuilder b)]) = _$GetManyBaseGuidelinesControllerGuideline200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseGuidelinesControllerGuideline200Response> get serializer => _$GetManyBaseGuidelinesControllerGuideline200ResponseSerializer();
}

class _$GetManyBaseGuidelinesControllerGuideline200ResponseSerializer implements StructuredSerializer<GetManyBaseGuidelinesControllerGuideline200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseGuidelinesControllerGuideline200Response, _$GetManyBaseGuidelinesControllerGuideline200Response];

    @override
    final String wireName = r'GetManyBaseGuidelinesControllerGuideline200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseGuidelinesControllerGuideline200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(Guideline)])));
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
    GetManyBaseGuidelinesControllerGuideline200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseGuidelinesControllerGuideline200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Guideline)])) as BuiltList<Guideline>;
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

