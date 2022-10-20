//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_reset_password_admin_dto.g.dart';

/// AuthResetPasswordAdminDto
///
/// Properties:
/// * [password] 
abstract class AuthResetPasswordAdminDto implements Built<AuthResetPasswordAdminDto, AuthResetPasswordAdminDtoBuilder> {
    @BuiltValueField(wireName: r'password')
    String get password;

    AuthResetPasswordAdminDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AuthResetPasswordAdminDtoBuilder b) => b;

    factory AuthResetPasswordAdminDto([void updates(AuthResetPasswordAdminDtoBuilder b)]) = _$AuthResetPasswordAdminDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<AuthResetPasswordAdminDto> get serializer => _$AuthResetPasswordAdminDtoSerializer();
}

class _$AuthResetPasswordAdminDtoSerializer implements StructuredSerializer<AuthResetPasswordAdminDto> {
    @override
    final Iterable<Type> types = const [AuthResetPasswordAdminDto, _$AuthResetPasswordAdminDto];

    @override
    final String wireName = r'AuthResetPasswordAdminDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, AuthResetPasswordAdminDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'password')
            ..add(serializers.serialize(object.password,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    AuthResetPasswordAdminDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AuthResetPasswordAdminDtoBuilder();

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
            }
        }
        return result.build();
    }
}

