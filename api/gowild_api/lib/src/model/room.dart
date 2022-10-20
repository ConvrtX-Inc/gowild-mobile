//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'room.g.dart';

/// Room
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [name] 
/// * [type] 
abstract class Room implements Built<Room, RoomBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'name')
    String get name;

    @BuiltValueField(wireName: r'type')
    String get type;

    Room._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(RoomBuilder b) => b;

    factory Room([void updates(RoomBuilder b)]) = _$Room;

    @BuiltValueSerializer(custom: true)
    static Serializer<Room> get serializer => _$RoomSerializer();
}

class _$RoomSerializer implements StructuredSerializer<Room> {
    @override
    final Iterable<Type> types = const [Room, _$Room];

    @override
    final String wireName = r'Room';

    @override
    Iterable<Object?> serialize(Serializers serializers, Room object,
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
            ..add(r'name')
            ..add(serializers.serialize(object.name,
                specifiedType: const FullType(String)));
        result
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Room deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = RoomBuilder();

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
                case r'name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.name = valueDes;
                    break;
                case r'type':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.type = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

