//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/simple_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_token.g.dart';

/// AccessToken
///
/// Properties:
/// * [user] 
/// * [email] 
abstract class AccessToken implements Built<AccessToken, AccessTokenBuilder> {
    @BuiltValueField(wireName: r'user')
    SimpleUser get user;

    @BuiltValueField(wireName: r'email')
    String get email;

    AccessToken._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AccessTokenBuilder b) => b;

    factory AccessToken([void updates(AccessTokenBuilder b)]) = _$AccessToken;

    @BuiltValueSerializer(custom: true)
    static Serializer<AccessToken> get serializer => _$AccessTokenSerializer();
}

class _$AccessTokenSerializer implements StructuredSerializer<AccessToken> {
    @override
    final Iterable<Type> types = const [AccessToken, _$AccessToken];

    @override
    final String wireName = r'AccessToken';

    @override
    Iterable<Object?> serialize(Serializers serializers, AccessToken object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
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
    AccessToken deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AccessTokenBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
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

