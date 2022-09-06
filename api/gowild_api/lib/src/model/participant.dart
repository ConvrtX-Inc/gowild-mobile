//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'participant.g.dart';

/// Participant
///
/// Properties:
/// * [userId] 
/// * [roomId] 
abstract class Participant implements Built<Participant, ParticipantBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'room_id')
    String get roomId;

    Participant._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(ParticipantBuilder b) => b;

    factory Participant([void updates(ParticipantBuilder b)]) = _$Participant;

    @BuiltValueSerializer(custom: true)
    static Serializer<Participant> get serializer => _$ParticipantSerializer();
}

class _$ParticipantSerializer implements StructuredSerializer<Participant> {
    @override
    final Iterable<Type> types = const [Participant, _$Participant];

    @override
    final String wireName = r'Participant';

    @override
    Iterable<Object?> serialize(Serializers serializers, Participant object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'room_id')
            ..add(serializers.serialize(object.roomId,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Participant deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ParticipantBuilder();

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
                case r'room_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.roomId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

