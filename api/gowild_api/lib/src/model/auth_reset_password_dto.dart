//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_reset_password_dto.g.dart';

/// AuthResetPasswordDto
///
/// Properties:
/// * [password] 
/// * [hash] 
abstract class AuthResetPasswordDto implements Built<AuthResetPasswordDto, AuthResetPasswordDtoBuilder> {
    @BuiltValueField(wireName: r'password')
    String get password;

    @BuiltValueField(wireName: r'hash')
    String get hash;

    AuthResetPasswordDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AuthResetPasswordDtoBuilder b) => b;

    factory AuthResetPasswordDto([void updates(AuthResetPasswordDtoBuilder b)]) = _$AuthResetPasswordDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<AuthResetPasswordDto> get serializer => _$AuthResetPasswordDtoSerializer();
}

class _$AuthResetPasswordDtoSerializer implements StructuredSerializer<AuthResetPasswordDto> {
    @override
    final Iterable<Type> types = const [AuthResetPasswordDto, _$AuthResetPasswordDto];

    @override
    final String wireName = r'AuthResetPasswordDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, AuthResetPasswordDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'password')
            ..add(serializers.serialize(object.password,
                specifiedType: const FullType(String)));
        result
            ..add(r'hash')
            ..add(serializers.serialize(object.hash,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    AuthResetPasswordDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AuthResetPasswordDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'password':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.password = valueDes;
                    break;
                case r'hash':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.hash = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

