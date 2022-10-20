//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ticket_message.g.dart';

/// TicketMessage
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [ticketId] 
/// * [userId] 
/// * [message] 
abstract class TicketMessage implements Built<TicketMessage, TicketMessageBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'ticket_id')
    String get ticketId;

    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'message')
    String get message;

    TicketMessage._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TicketMessageBuilder b) => b;

    factory TicketMessage([void updates(TicketMessageBuilder b)]) = _$TicketMessage;

    @BuiltValueSerializer(custom: true)
    static Serializer<TicketMessage> get serializer => _$TicketMessageSerializer();
}

class _$TicketMessageSerializer implements StructuredSerializer<TicketMessage> {
    @override
    final Iterable<Type> types = const [TicketMessage, _$TicketMessage];

    @override
    final String wireName = r'TicketMessage';

    @override
    Iterable<Object?> serialize(Serializers serializers, TicketMessage object,
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
            ..add(r'ticket_id')
            ..add(serializers.serialize(object.ticketId,
                specifiedType: const FullType(String)));
        result
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'message')
            ..add(serializers.serialize(object.message,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    TicketMessage deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TicketMessageBuilder();

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
                case r'ticket_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.ticketId = valueDes;
                    break;
                case r'user_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.userId = valueDes;
                    break;
                case r'message':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.message = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

