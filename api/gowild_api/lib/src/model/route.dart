//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/route_user.dart';
import 'package:gowild_api/src/model/user_entity_picture.dart';
import 'package:gowild_api/src/model/route_historical_event.dart';
import 'package:gowild_api/src/model/route_historical_event_point.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route.g.dart';

/// Route
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [user] 
/// * [title] 
/// * [start] 
/// * [end] 
/// * [historicalEvents] 
/// * [picture] 
/// * [description] 
abstract class Route implements Built<Route, RouteBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'user')
    RouteUser? get user;

    @BuiltValueField(wireName: r'title')
    String? get title;

    @BuiltValueField(wireName: r'start')
    RouteHistoricalEventPoint? get start;

    @BuiltValueField(wireName: r'end')
    RouteHistoricalEventPoint? get end;

    @BuiltValueField(wireName: r'historicalEvents')
    BuiltList<RouteHistoricalEvent>? get historicalEvents;

    @BuiltValueField(wireName: r'picture')
    UserEntityPicture? get picture;

    @BuiltValueField(wireName: r'description')
    String? get description;

    Route._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(RouteBuilder b) => b;

    factory Route([void updates(RouteBuilder b)]) = _$Route;

    @BuiltValueSerializer(custom: true)
    static Serializer<Route> get serializer => _$RouteSerializer();
}

class _$RouteSerializer implements StructuredSerializer<Route> {
    @override
    final Iterable<Type> types = const [Route, _$Route];

    @override
    final String wireName = r'Route';

    @override
    Iterable<Object?> serialize(Serializers serializers, Route object,
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
            ..add(r'user')
            ..add(object.user == null ? null : serializers.serialize(object.user,
                specifiedType: const FullType.nullable(RouteUser)));
        result
            ..add(r'title')
            ..add(object.title == null ? null : serializers.serialize(object.title,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'start')
            ..add(object.start == null ? null : serializers.serialize(object.start,
                specifiedType: const FullType.nullable(RouteHistoricalEventPoint)));
        result
            ..add(r'end')
            ..add(object.end == null ? null : serializers.serialize(object.end,
                specifiedType: const FullType.nullable(RouteHistoricalEventPoint)));
        result
            ..add(r'historicalEvents')
            ..add(object.historicalEvents == null ? null : serializers.serialize(object.historicalEvents,
                specifiedType: const FullType.nullable(BuiltList, [FullType(RouteHistoricalEvent)])));
        result
            ..add(r'picture')
            ..add(object.picture == null ? null : serializers.serialize(object.picture,
                specifiedType: const FullType.nullable(UserEntityPicture)));
        result
            ..add(r'description')
            ..add(object.description == null ? null : serializers.serialize(object.description,
                specifiedType: const FullType.nullable(String)));
        return result;
    }

    @override
    Route deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = RouteBuilder();

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
                case r'user':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(RouteUser)) as RouteUser?;
                    if (valueDes == null) continue;
                    result.user.replace(valueDes);
                    break;
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.title = valueDes;
                    break;
                case r'start':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(RouteHistoricalEventPoint)) as RouteHistoricalEventPoint?;
                    if (valueDes == null) continue;
                    result.start.replace(valueDes);
                    break;
                case r'end':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(RouteHistoricalEventPoint)) as RouteHistoricalEventPoint?;
                    if (valueDes == null) continue;
                    result.end.replace(valueDes);
                    break;
                case r'historicalEvents':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(BuiltList, [FullType(RouteHistoricalEvent)])) as BuiltList<RouteHistoricalEvent>?;
                    if (valueDes == null) continue;
                    result.historicalEvents.replace(valueDes);
                    break;
                case r'picture':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(UserEntityPicture)) as UserEntityPicture?;
                    if (valueDes == null) continue;
                    result.picture.replace(valueDes);
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.description = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

