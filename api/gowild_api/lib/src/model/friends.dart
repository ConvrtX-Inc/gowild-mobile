//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friends.g.dart';

/// Friends
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [userId] 
/// * [friendId] 
/// * [isApproved] 
abstract class Friends implements Built<Friends, FriendsBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'friend_id')
    String get friendId;

    @BuiltValueField(wireName: r'is_approved')
    bool get isApproved;

    Friends._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(FriendsBuilder b) => b;

    factory Friends([void updates(FriendsBuilder b)]) = _$Friends;

    @BuiltValueSerializer(custom: true)
    static Serializer<Friends> get serializer => _$FriendsSerializer();
}

class _$FriendsSerializer implements StructuredSerializer<Friends> {
    @override
    final Iterable<Type> types = const [Friends, _$Friends];

    @override
    final String wireName = r'Friends';

    @override
    Iterable<Object?> serialize(Serializers serializers, Friends object,
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
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'friend_id')
            ..add(serializers.serialize(object.friendId,
                specifiedType: const FullType(String)));
        result
            ..add(r'is_approved')
            ..add(serializers.serialize(object.isApproved,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    Friends deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = FriendsBuilder();

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
                case r'user_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.userId = valueDes;
                    break;
                case r'friend_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.friendId = valueDes;
                    break;
                case r'is_approved':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.isApproved = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

