//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/route_historical_event_route.dart';
import 'package:gowild_api/src/model/file_entity.dart';
import 'package:gowild_api/src/model/user_entity_picture.dart';
import 'package:gowild_api/src/model/route_historical_event_point.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_historical_event.g.dart';

/// RouteHistoricalEvent
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [route] 
/// * [closureUid] 
/// * [point] 
/// * [title] 
/// * [subtitle] 
/// * [description] 
/// * [image] 
/// * [medias] 
abstract class RouteHistoricalEvent implements Built<RouteHistoricalEvent, RouteHistoricalEventBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'route')
    RouteHistoricalEventRoute? get route;

    @BuiltValueField(wireName: r'closureUid')
    String? get closureUid;

    @BuiltValueField(wireName: r'point')
    RouteHistoricalEventPoint? get point;

    @BuiltValueField(wireName: r'title')
    String? get title;

    @BuiltValueField(wireName: r'subtitle')
    String? get subtitle;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'image')
    UserEntityPicture? get image;

    @BuiltValueField(wireName: r'medias')
    BuiltList<FileEntity>? get medias;

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
            ..add(r'route')
            ..add(object.route == null ? null : serializers.serialize(object.route,
                specifiedType: const FullType.nullable(RouteHistoricalEventRoute)));
        result
            ..add(r'closureUid')
            ..add(object.closureUid == null ? null : serializers.serialize(object.closureUid,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'point')
            ..add(object.point == null ? null : serializers.serialize(object.point,
                specifiedType: const FullType.nullable(RouteHistoricalEventPoint)));
        result
            ..add(r'title')
            ..add(object.title == null ? null : serializers.serialize(object.title,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'subtitle')
            ..add(object.subtitle == null ? null : serializers.serialize(object.subtitle,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'description')
            ..add(object.description == null ? null : serializers.serialize(object.description,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'image')
            ..add(object.image == null ? null : serializers.serialize(object.image,
                specifiedType: const FullType.nullable(UserEntityPicture)));
        result
            ..add(r'medias')
            ..add(object.medias == null ? null : serializers.serialize(object.medias,
                specifiedType: const FullType.nullable(BuiltList, [FullType(FileEntity)])));
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
                case r'route':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(RouteHistoricalEventRoute)) as RouteHistoricalEventRoute?;
                    if (valueDes == null) continue;
                    result.route.replace(valueDes);
                    break;
                case r'closureUid':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.closureUid = valueDes;
                    break;
                case r'point':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(RouteHistoricalEventPoint)) as RouteHistoricalEventPoint?;
                    if (valueDes == null) continue;
                    result.point.replace(valueDes);
                    break;
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.title = valueDes;
                    break;
                case r'subtitle':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.subtitle = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.description = valueDes;
                    break;
                case r'image':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(UserEntityPicture)) as UserEntityPicture?;
                    if (valueDes == null) continue;
                    result.image.replace(valueDes);
                    break;
                case r'medias':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(BuiltList, [FullType(FileEntity)])) as BuiltList<FileEntity>?;
                    if (valueDes == null) continue;
                    result.medias.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

