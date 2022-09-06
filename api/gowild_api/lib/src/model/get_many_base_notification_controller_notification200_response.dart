//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/get_many_notification_response_dto.dart';
import 'package:gowild_api/src/model/notification.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_many_base_notification_controller_notification200_response.g.dart';

/// GetManyBaseNotificationControllerNotification200Response
///
/// Properties:
/// * [data] 
/// * [count] 
/// * [total] 
/// * [page] 
/// * [pageCount] 
abstract class GetManyBaseNotificationControllerNotification200Response implements Built<GetManyBaseNotificationControllerNotification200Response, GetManyBaseNotificationControllerNotification200ResponseBuilder> {
    @BuiltValueField(wireName: r'data')
    BuiltList<Notification> get data;

    @BuiltValueField(wireName: r'count')
    num get count;

    @BuiltValueField(wireName: r'total')
    num get total;

    @BuiltValueField(wireName: r'page')
    num get page;

    @BuiltValueField(wireName: r'pageCount')
    num get pageCount;

    GetManyBaseNotificationControllerNotification200Response._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GetManyBaseNotificationControllerNotification200ResponseBuilder b) => b;

    factory GetManyBaseNotificationControllerNotification200Response([void updates(GetManyBaseNotificationControllerNotification200ResponseBuilder b)]) = _$GetManyBaseNotificationControllerNotification200Response;

    @BuiltValueSerializer(custom: true)
    static Serializer<GetManyBaseNotificationControllerNotification200Response> get serializer => _$GetManyBaseNotificationControllerNotification200ResponseSerializer();
}

class _$GetManyBaseNotificationControllerNotification200ResponseSerializer implements StructuredSerializer<GetManyBaseNotificationControllerNotification200Response> {
    @override
    final Iterable<Type> types = const [GetManyBaseNotificationControllerNotification200Response, _$GetManyBaseNotificationControllerNotification200Response];

    @override
    final String wireName = r'GetManyBaseNotificationControllerNotification200Response';

    @override
    Iterable<Object?> serialize(Serializers serializers, GetManyBaseNotificationControllerNotification200Response object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'data')
            ..add(serializers.serialize(object.data,
                specifiedType: const FullType(BuiltList, [FullType(Notification)])));
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
    GetManyBaseNotificationControllerNotification200Response deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GetManyBaseNotificationControllerNotification200ResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'data':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Notification)])) as BuiltList<Notification>;
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

