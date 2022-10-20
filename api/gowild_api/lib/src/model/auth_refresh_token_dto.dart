//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_refresh_token_dto.g.dart';

/// AuthRefreshTokenDto
///
/// Properties:
/// * [refreshToken] 
abstract class AuthRefreshTokenDto implements Built<AuthRefreshTokenDto, AuthRefreshTokenDtoBuilder> {
    @BuiltValueField(wireName: r'refreshToken')
    String get refreshToken;

    AuthRefreshTokenDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AuthRefreshTokenDtoBuilder b) => b;

    factory AuthRefreshTokenDto([void updates(AuthRefreshTokenDtoBuilder b)]) = _$AuthRefreshTokenDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<AuthRefreshTokenDto> get serializer => _$AuthRefreshTokenDtoSerializer();
}

class _$AuthRefreshTokenDtoSerializer implements StructuredSerializer<AuthRefreshTokenDto> {
    @override
    final Iterable<Type> types = const [AuthRefreshTokenDto, _$AuthRefreshTokenDto];

    @override
    final String wireName = r'AuthRefreshTokenDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, AuthRefreshTokenDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'refreshToken')
            ..add(serializers.serialize(object.refreshToken,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    AuthRefreshTokenDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AuthRefreshTokenDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'refreshToken':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.refreshToken = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

