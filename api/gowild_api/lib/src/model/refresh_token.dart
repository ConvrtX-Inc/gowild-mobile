//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/simple_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'refresh_token.g.dart';

/// RefreshToken
///
/// Properties:
/// * [rid] 
/// * [user] 
/// * [email] 
abstract class RefreshToken implements Built<RefreshToken, RefreshTokenBuilder> {
    @BuiltValueField(wireName: r'rid')
    String get rid;

    @BuiltValueField(wireName: r'user')
    SimpleUser get user;

    @BuiltValueField(wireName: r'email')
    String get email;

    RefreshToken._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(RefreshTokenBuilder b) => b;

    factory RefreshToken([void updates(RefreshTokenBuilder b)]) = _$RefreshToken;

    @BuiltValueSerializer(custom: true)
    static Serializer<RefreshToken> get serializer => _$RefreshTokenSerializer();
}

class _$RefreshTokenSerializer implements StructuredSerializer<RefreshToken> {
    @override
    final Iterable<Type> types = const [RefreshToken, _$RefreshToken];

    @override
    final String wireName = r'RefreshToken';

    @override
    Iterable<Object?> serialize(Serializers serializers, RefreshToken object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'rid')
            ..add(serializers.serialize(object.rid,
                specifiedType: const FullType(String)));
        result
            ..add(r'user')
            ..add(serializers.serialize(object.user,
                specifiedType: const FullType(SimpleUser)));
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    RefreshToken deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = RefreshTokenBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'rid':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.rid = valueDes;
                    break;
                case r'user':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(SimpleUser)) as SimpleUser;
                    result.user.replace(valueDes);
                    break;
                case r'email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.email = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

