//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_clue.g.dart';

/// RouteClue
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [routeId] 
/// * [locationPointLong] 
/// * [locationPointLat] 
/// * [cluePointLong] 
/// * [cluePointLat] 
/// * [clueTitle] 
/// * [description] 
/// * [clueImg] 
/// * [videoUrl] 
/// * [arClue] 
abstract class RouteClue implements Built<RouteClue, RouteClueBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'route_id')
    String get routeId;

    @BuiltValueField(wireName: r'location_point_long')
    double get locationPointLong;

    @BuiltValueField(wireName: r'location_point_lat')
    double get locationPointLat;

    @BuiltValueField(wireName: r'clue_point_long')
    double get cluePointLong;

    @BuiltValueField(wireName: r'clue_point_lat')
    double get cluePointLat;

    @BuiltValueField(wireName: r'clue_title')
    String get clueTitle;

    @BuiltValueField(wireName: r'description')
    String get description;

    @BuiltValueField(wireName: r'clue_img')
    JsonObject get clueImg;

    @BuiltValueField(wireName: r'video_url')
    String get videoUrl;

    @BuiltValueField(wireName: r'ar_clue')
    String get arClue;

    RouteClue._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(RouteClueBuilder b) => b;

    factory RouteClue([void updates(RouteClueBuilder b)]) = _$RouteClue;

    @BuiltValueSerializer(custom: true)
    static Serializer<RouteClue> get serializer => _$RouteClueSerializer();
}

class _$RouteClueSerializer implements StructuredSerializer<RouteClue> {
    @override
    final Iterable<Type> types = const [RouteClue, _$RouteClue];

    @override
    final String wireName = r'RouteClue';

    @override
    Iterable<Object?> serialize(Serializers serializers, RouteClue object,
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
            ..add(r'route_id')
            ..add(serializers.serialize(object.routeId,
                specifiedType: const FullType(String)));
        result
            ..add(r'location_point_long')
            ..add(serializers.serialize(object.locationPointLong,
                specifiedType: const FullType(double)));
        result
            ..add(r'location_point_lat')
            ..add(serializers.serialize(object.locationPointLat,
                specifiedType: const FullType(double)));
        result
            ..add(r'clue_point_long')
            ..add(serializers.serialize(object.cluePointLong,
                specifiedType: const FullType(double)));
        result
            ..add(r'clue_point_lat')
            ..add(serializers.serialize(object.cluePointLat,
                specifiedType: const FullType(double)));
        result
            ..add(r'clue_title')
            ..add(serializers.serialize(object.clueTitle,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        result
            ..add(r'clue_img')
            ..add(serializers.serialize(object.clueImg,
                specifiedType: const FullType(JsonObject)));
        result
            ..add(r'video_url')
            ..add(serializers.serialize(object.videoUrl,
                specifiedType: const FullType(String)));
        result
            ..add(r'ar_clue')
            ..add(serializers.serialize(object.arClue,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    RouteClue deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = RouteClueBuilder();

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
                case r'route_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.routeId = valueDes;
                    break;
                case r'location_point_long':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(double)) as double;
                    result.locationPointLong = valueDes;
                    break;
                case r'location_point_lat':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(double)) as double;
                    result.locationPointLat = valueDes;
                    break;
                case r'clue_point_long':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(double)) as double;
                    result.cluePointLong = valueDes;
                    break;
                case r'clue_point_lat':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(double)) as double;
                    result.cluePointLat = valueDes;
                    break;
                case r'clue_title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.clueTitle = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'clue_img':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(JsonObject)) as JsonObject;
                    result.clueImg = valueDes;
                    break;
                case r'video_url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.videoUrl = valueDes;
                    break;
                case r'ar_clue':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.arClue = valueDes;
                    break;
            }
        }
        return result.build();
    }
}
