//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_historical_event.g.dart';

/// RouteHistoricalEvent
///
/// Properties:
/// * [routeId] 
/// * [closureUid] 
/// * [eventLong] 
/// * [eventLat] 
/// * [eventTitle] 
/// * [eventSubtitle] 
/// * [description] 
abstract class RouteHistoricalEvent implements Built<RouteHistoricalEvent, RouteHistoricalEventBuilder> {
    @BuiltValueField(wireName: r'route_id')
    String get routeId;

    @BuiltValueField(wireName: r'closure_uid')
    String get closureUid;

    @BuiltValueField(wireName: r'event_long')
    num get eventLong;

    @BuiltValueField(wireName: r'event_lat')
    num get eventLat;

    @BuiltValueField(wireName: r'event_title')
    String get eventTitle;

    @BuiltValueField(wireName: r'event_subtitle')
    String get eventSubtitle;

    @BuiltValueField(wireName: r'description')
    String get description;

    RouteHistoricalEvent._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(RouteHistoricalEventBuilder b) => b;

    factory RouteHistoricalEvent([void updates(RouteHistoricalEventBuilder b)]) = _$RouteHistoricalEvent;

    @BuiltValueSerializer(custom: true)
    static Serializer<RouteHistoricalEvent> get serializer => _$RouteHistoricalEventSerializer();
}

class _$RouteHistoricalEventSerializer implements StructuredSerializer<RouteHistoricalEvent> {
    @override
    final Iterable<Type> types = const [RouteHistoricalEvent, _$RouteHistoricalEvent];

    @override
    final String wireName = r'RouteHistoricalEvent';

    @override
    Iterable<Object?> serialize(Serializers serializers, RouteHistoricalEvent object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'route_id')
            ..add(serializers.serialize(object.routeId,
                specifiedType: const FullType(String)));
        result
            ..add(r'closure_uid')
            ..add(serializers.serialize(object.closureUid,
                specifiedType: const FullType(String)));
        result
            ..add(r'event_long')
            ..add(serializers.serialize(object.eventLong,
                specifiedType: const FullType(num)));
        result
            ..add(r'event_lat')
            ..add(serializers.serialize(object.eventLat,
                specifiedType: const FullType(num)));
        result
            ..add(r'event_title')
            ..add(serializers.serialize(object.eventTitle,
                specifiedType: const FullType(String)));
        result
            ..add(r'event_subtitle')
            ..add(serializers.serialize(object.eventSubtitle,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    RouteHistoricalEvent deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = RouteHistoricalEventBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'route_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.routeId = valueDes;
                    break;
                case r'closure_uid':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.closureUid = valueDes;
                    break;
                case r'event_long':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.eventLong = valueDes;
                    break;
                case r'event_lat':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.eventLat = valueDes;
                    break;
                case r'event_title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.eventTitle = valueDes;
                    break;
                case r'event_subtitle':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.eventSubtitle = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

