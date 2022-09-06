//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'treasure_chest.g.dart';

/// TreasureChest
///
/// Properties:
/// * [title] 
/// * [description] 
/// * [locationLong] 
/// * [locationLat] 
/// * [eventDate] 
/// * [eventTime] 
/// * [noOfParticipants] 
/// * [imgUrl] 
/// * [thumbnailImg] 
/// * [aR] 
abstract class TreasureChest implements Built<TreasureChest, TreasureChestBuilder> {
    @BuiltValueField(wireName: r'title')
    String get title;

    @BuiltValueField(wireName: r'description')
    String get description;

    @BuiltValueField(wireName: r'location_long')
    num get locationLong;

    @BuiltValueField(wireName: r'location_lat')
    num get locationLat;

    @BuiltValueField(wireName: r'event_date')
    DateTime get eventDate;

    @BuiltValueField(wireName: r'event_time')
    String get eventTime;

    @BuiltValueField(wireName: r'no_of_participants')
    num get noOfParticipants;

    @BuiltValueField(wireName: r'img_url')
    String get imgUrl;

    @BuiltValueField(wireName: r'thumbnail_img')
    JsonObject get thumbnailImg;

    @BuiltValueField(wireName: r'a_r')
    String get aR;

    TreasureChest._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TreasureChestBuilder b) => b;

    factory TreasureChest([void updates(TreasureChestBuilder b)]) = _$TreasureChest;

    @BuiltValueSerializer(custom: true)
    static Serializer<TreasureChest> get serializer => _$TreasureChestSerializer();
}

class _$TreasureChestSerializer implements StructuredSerializer<TreasureChest> {
    @override
    final Iterable<Type> types = const [TreasureChest, _$TreasureChest];

    @override
    final String wireName = r'TreasureChest';

    @override
    Iterable<Object?> serialize(Serializers serializers, TreasureChest object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'title')
            ..add(serializers.serialize(object.title,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        result
            ..add(r'location_long')
            ..add(serializers.serialize(object.locationLong,
                specifiedType: const FullType(num)));
        result
            ..add(r'location_lat')
            ..add(serializers.serialize(object.locationLat,
                specifiedType: const FullType(num)));
        result
            ..add(r'event_date')
            ..add(serializers.serialize(object.eventDate,
                specifiedType: const FullType(DateTime)));
        result
            ..add(r'event_time')
            ..add(serializers.serialize(object.eventTime,
                specifiedType: const FullType(String)));
        result
            ..add(r'no_of_participants')
            ..add(serializers.serialize(object.noOfParticipants,
                specifiedType: const FullType(num)));
        result
            ..add(r'img_url')
            ..add(serializers.serialize(object.imgUrl,
                specifiedType: const FullType(String)));
        result
            ..add(r'thumbnail_img')
            ..add(serializers.serialize(object.thumbnailImg,
                specifiedType: const FullType(JsonObject)));
        result
            ..add(r'a_r')
            ..add(serializers.serialize(object.aR,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    TreasureChest deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TreasureChestBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.title = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'location_long':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.locationLong = valueDes;
                    break;
                case r'location_lat':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.locationLat = valueDes;
                    break;
                case r'event_date':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    result.eventDate = valueDes;
                    break;
                case r'event_time':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.eventTime = valueDes;
                    break;
                case r'no_of_participants':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.noOfParticipants = valueDes;
                    break;
                case r'img_url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.imgUrl = valueDes;
                    break;
                case r'thumbnail_img':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(JsonObject)) as JsonObject;
                    result.thumbnailImg = valueDes;
                    break;
                case r'a_r':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.aR = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

