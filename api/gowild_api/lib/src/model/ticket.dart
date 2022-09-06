//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ticket.g.dart';

/// Ticket
///
/// Properties:
/// * [userId] 
/// * [subject] 
/// * [message] 
/// * [imgUrl] 
/// * [status] 
abstract class Ticket implements Built<Ticket, TicketBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'subject')
    String get subject;

    @BuiltValueField(wireName: r'message')
    String get message;

    @BuiltValueField(wireName: r'img_url')
    String get imgUrl;

    @BuiltValueField(wireName: r'status')
    num get status;

    Ticket._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TicketBuilder b) => b;

    factory Ticket([void updates(TicketBuilder b)]) = _$Ticket;

    @BuiltValueSerializer(custom: true)
    static Serializer<Ticket> get serializer => _$TicketSerializer();
}

class _$TicketSerializer implements StructuredSerializer<Ticket> {
    @override
    final Iterable<Type> types = const [Ticket, _$Ticket];

    @override
    final String wireName = r'Ticket';

    @override
    Iterable<Object?> serialize(Serializers serializers, Ticket object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'subject')
            ..add(serializers.serialize(object.subject,
                specifiedType: const FullType(String)));
        result
            ..add(r'message')
            ..add(serializers.serialize(object.message,
                specifiedType: const FullType(String)));
        result
            ..add(r'img_url')
            ..add(serializers.serialize(object.imgUrl,
                specifiedType: const FullType(String)));
        result
            ..add(r'status')
            ..add(serializers.serialize(object.status,
                specifiedType: const FullType(num)));
        return result;
    }

    @override
    Ticket deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TicketBuilder();

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
                case r'subject':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.subject = valueDes;
                    break;
                case r'message':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.message = valueDes;
                    break;
                case r'img_url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.imgUrl = valueDes;
                    break;
                case r'status':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.status = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

