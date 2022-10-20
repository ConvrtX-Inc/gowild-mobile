//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/app_point.dart';
import 'package:gowild_api/src/model/user_entity_picture.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'treasure_chest.g.dart';

/// TreasureChest
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [title] 
/// * [description] 
/// * [location] 
/// * [eventDate] 
/// * [eventTime] 
/// * [noOfParticipants] 
/// * [picture] 
/// * [aR] 
abstract class TreasureChest implements Built<TreasureChest, TreasureChestBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'title')
    String get title;

    @BuiltValueField(wireName: r'description')
    String get description;

    @BuiltValueField(wireName: r'location')
    AppPoint get location;

    @BuiltValueField(wireName: r'event_date')
    DateTime get eventDate;

    @BuiltValueField(wireName: r'event_time')
    String get eventTime;

    @BuiltValueField(wireName: r'no_of_participants')
    num get noOfParticipants;

    @BuiltValueField(wireName: r'picture')
    UserEntityPicture? get picture;

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
            ..add(r'title')
            ..add(serializers.serialize(object.title,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        result
            ..add(r'location')
            ..add(serializers.serialize(object.location,
                specifiedType: const FullType(AppPoint)));
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
            ..add(r'picture')
            ..add(object.picture == null ? null : serializers.serialize(object.picture,
                specifiedType: const FullType.nullable(UserEntityPicture)));
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
                case r'location':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(AppPoint)) as AppPoint;
                    result.location.replace(valueDes);
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
                case r'picture':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(UserEntityPicture)) as UserEntityPicture?;
                    if (valueDes == null) continue;
                    result.picture.replace(valueDes);
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

