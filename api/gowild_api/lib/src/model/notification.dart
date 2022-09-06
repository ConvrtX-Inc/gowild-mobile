//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification.g.dart';

/// Notification
///
/// Properties:
/// * [userId] 
/// * [notificationMsg] 
abstract class Notification implements Built<Notification, NotificationBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'notification_msg')
    String get notificationMsg;

    Notification._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(NotificationBuilder b) => b;

    factory Notification([void updates(NotificationBuilder b)]) = _$Notification;

    @BuiltValueSerializer(custom: true)
    static Serializer<Notification> get serializer => _$NotificationSerializer();
}

class _$NotificationSerializer implements StructuredSerializer<Notification> {
    @override
    final Iterable<Type> types = const [Notification, _$Notification];

    @override
    final String wireName = r'Notification';

    @override
    Iterable<Object?> serialize(Serializers serializers, Notification object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'notification_msg')
            ..add(serializers.serialize(object.notificationMsg,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Notification deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = NotificationBuilder();

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
                case r'notification_msg':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.notificationMsg = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

