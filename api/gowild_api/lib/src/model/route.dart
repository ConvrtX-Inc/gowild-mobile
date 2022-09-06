//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route.g.dart';

/// Route
///
/// Properties:
/// * [userId] 
/// * [routeName] 
/// * [routePhoto] 
/// * [startPointLong] 
/// * [startPointLat] 
/// * [stopPointLong] 
/// * [stopPointLat] 
/// * [imgUrl] 
/// * [description] 
abstract class Route implements Built<Route, RouteBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'route_name')
    String get routeName;

    @BuiltValueField(wireName: r'route_photo')
    JsonObject get routePhoto;

    @BuiltValueField(wireName: r'start_point_long')
    num get startPointLong;

    @BuiltValueField(wireName: r'start_point_lat')
    num get startPointLat;

    @BuiltValueField(wireName: r'stop_point_long')
    num get stopPointLong;

    @BuiltValueField(wireName: r'stop_point_lat')
    num get stopPointLat;

    @BuiltValueField(wireName: r'img_url')
    String get imgUrl;

    @BuiltValueField(wireName: r'description')
    String get description;

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
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'route_name')
            ..add(serializers.serialize(object.routeName,
                specifiedType: const FullType(String)));
        result
            ..add(r'route_photo')
            ..add(serializers.serialize(object.routePhoto,
                specifiedType: const FullType(JsonObject)));
        result
            ..add(r'start_point_long')
            ..add(serializers.serialize(object.startPointLong,
                specifiedType: const FullType(num)));
        result
            ..add(r'start_point_lat')
            ..add(serializers.serialize(object.startPointLat,
                specifiedType: const FullType(num)));
        result
            ..add(r'stop_point_long')
            ..add(serializers.serialize(object.stopPointLong,
                specifiedType: const FullType(num)));
        result
            ..add(r'stop_point_lat')
            ..add(serializers.serialize(object.stopPointLat,
                specifiedType: const FullType(num)));
        result
            ..add(r'img_url')
            ..add(serializers.serialize(object.imgUrl,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
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
                case r'user_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.userId = valueDes;
                    break;
                case r'route_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.routeName = valueDes;
                    break;
                case r'route_photo':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(JsonObject)) as JsonObject;
                    result.routePhoto = valueDes;
                    break;
                case r'start_point_long':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.startPointLong = valueDes;
                    break;
                case r'start_point_lat':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.startPointLat = valueDes;
                    break;
                case r'stop_point_long':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.stopPointLong = valueDes;
                    break;
                case r'stop_point_lat':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.stopPointLat = valueDes;
                    break;
                case r'img_url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.imgUrl = valueDes;
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

