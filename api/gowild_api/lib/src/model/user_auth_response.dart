//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/user.dart';
import 'package:gowild_api/src/model/token_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_auth_response.g.dart';

/// UserAuthResponse
///
/// Properties:
/// * [token] 
/// * [user] 
abstract class UserAuthResponse implements Built<UserAuthResponse, UserAuthResponseBuilder> {
    @BuiltValueField(wireName: r'token')
    TokenResponse get token;

    @BuiltValueField(wireName: r'user')
    User get user;

    UserAuthResponse._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserAuthResponseBuilder b) => b;

    factory UserAuthResponse([void updates(UserAuthResponseBuilder b)]) = _$UserAuthResponse;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserAuthResponse> get serializer => _$UserAuthResponseSerializer();
}

class _$UserAuthResponseSerializer implements StructuredSerializer<UserAuthResponse> {
    @override
    final Iterable<Type> types = const [UserAuthResponse, _$UserAuthResponse];

    @override
    final String wireName = r'UserAuthResponse';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserAuthResponse object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'token')
            ..add(serializers.serialize(object.token,
                specifiedType: const FullType(TokenResponse)));
        result
            ..add(r'user')
            ..add(serializers.serialize(object.user,
                specifiedType: const FullType(User)));
        return result;
    }

    @override
    UserAuthResponse deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserAuthResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'token':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(TokenResponse)) as TokenResponse;
                    result.token.replace(valueDes);
                    break;
                case r'user':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(User)) as User;
                    result.user.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

