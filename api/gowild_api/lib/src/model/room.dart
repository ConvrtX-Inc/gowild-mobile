//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'room.g.dart';

/// Room
///
/// Properties:
/// * [name] 
/// * [type] 
abstract class Room implements Built<Room, RoomBuilder> {
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

