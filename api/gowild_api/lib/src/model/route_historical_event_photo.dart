//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_historical_event_photo.g.dart';

/// RouteHistoricalEventPhoto
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [routeHistoricalEventId] 
/// * [eventPhotoUrl] 
abstract class RouteHistoricalEventPhoto implements Built<RouteHistoricalEventPhoto, RouteHistoricalEventPhotoBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'route_historical_event_id')
    String get routeHistoricalEventId;

    @BuiltValueField(wireName: r'event_photo_url')
    String get eventPhotoUrl;

    RouteHistoricalEventPhoto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(RouteHistoricalEventPhotoBuilder b) => b;

    factory RouteHistoricalEventPhoto([void updates(RouteHistoricalEventPhotoBuilder b)]) = _$RouteHistoricalEventPhoto;

    @BuiltValueSerializer(custom: true)
    static Serializer<RouteHistoricalEventPhoto> get serializer => _$RouteHistoricalEventPhotoSerializer();
}

class _$RouteHistoricalEventPhotoSerializer implements StructuredSerializer<RouteHistoricalEventPhoto> {
    @override
    final Iterable<Type> types = const [RouteHistoricalEventPhoto, _$RouteHistoricalEventPhoto];

    @override
    final String wireName = r'RouteHistoricalEventPhoto';

    @override
    Iterable<Object?> serialize(Serializers serializers, RouteHistoricalEventPhoto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'createdDate')
            ..add(object.createdDate == null ? null : serializers.serialize(object.createdDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'updatedDate')
            ..add(object.updatedDate == null ? null : serializers.serialize(object.updatedDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'route_historical_event_id')
            ..add(serializers.serialize(object.routeHistoricalEventId,
                specifiedType: const FullType(String)));
        result
            ..add(r'event_photo_url')
            ..add(serializers.serialize(object.eventPhotoUrl,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    RouteHistoricalEventPhoto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = RouteHistoricalEventPhotoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.id = valueDes;
                    break;
                case r'createdDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.createdDate = valueDes;
                    break;
                case r'updatedDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.updatedDate = valueDes;
                    break;
                case r'route_historical_event_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.routeHistoricalEventId = valueDes;
                    break;
                case r'event_photo_url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.eventPhotoUrl = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

