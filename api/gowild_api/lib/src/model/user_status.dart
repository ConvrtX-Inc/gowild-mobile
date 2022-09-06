//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_status.g.dart';

/// UserStatus
///
/// Properties:
/// * [id] 
/// * [statusName] 
/// * [isActive] 
abstract class UserStatus implements Built<UserStatus, UserStatusBuilder> {
    @BuiltValueField(wireName: r'id')
    num get id;

    @BuiltValueField(wireName: r'status_name')
    String get statusName;

    @BuiltValueField(wireName: r'is_active')
    bool get isActive;

    UserStatus._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserStatusBuilder b) => b;

    factory UserStatus([void updates(UserStatusBuilder b)]) = _$UserStatus;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserStatus> get serializer => _$UserStatusSerializer();
}

class _$UserStatusSerializer implements StructuredSerializer<UserStatus> {
    @override
    final Iterable<Type> types = const [UserStatus, _$UserStatus];

    @override
    final String wireName = r'UserStatus';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserStatus object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(num)));
        result
            ..add(r'status_name')
            ..add(serializers.serialize(object.statusName,
                specifiedType: const FullType(String)));
        result
            ..add(r'is_active')
            ..add(serializers.serialize(object.isActive,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    UserStatus deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserStatusBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.id = valueDes;
                    break;
                case r'status_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.statusName = valueDes;
                    break;
                case r'is_active':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.isActive = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

