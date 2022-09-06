//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_facebook_login_dto.g.dart';

/// AuthFacebookLoginDto
///
/// Properties:
/// * [accessToken] 
abstract class AuthFacebookLoginDto implements Built<AuthFacebookLoginDto, AuthFacebookLoginDtoBuilder> {
    @BuiltValueField(wireName: r'access_token')
    String get accessToken;

    AuthFacebookLoginDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AuthFacebookLoginDtoBuilder b) => b;

    factory AuthFacebookLoginDto([void updates(AuthFacebookLoginDtoBuilder b)]) = _$AuthFacebookLoginDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<AuthFacebookLoginDto> get serializer => _$AuthFacebookLoginDtoSerializer();
}

class _$AuthFacebookLoginDtoSerializer implements StructuredSerializer<AuthFacebookLoginDto> {
    @override
    final Iterable<Type> types = const [AuthFacebookLoginDto, _$AuthFacebookLoginDto];

    @override
    final String wireName = r'AuthFacebookLoginDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, AuthFacebookLoginDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'access_token')
            ..add(serializers.serialize(object.accessToken,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    AuthFacebookLoginDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AuthFacebookLoginDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'access_token':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.accessToken = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

