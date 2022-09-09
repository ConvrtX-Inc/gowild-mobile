//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_forgot_password_dto.g.dart';

/// AuthForgotPasswordDto
///
/// Properties:
/// * [email] 
/// * [phone] 
abstract class AuthForgotPasswordDto implements Built<AuthForgotPasswordDto, AuthForgotPasswordDtoBuilder> {
    @BuiltValueField(wireName: r'email')
    String? get email;

    @BuiltValueField(wireName: r'phone')
    String? get phone;

    AuthForgotPasswordDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AuthForgotPasswordDtoBuilder b) => b;

    factory AuthForgotPasswordDto([void updates(AuthForgotPasswordDtoBuilder b)]) = _$AuthForgotPasswordDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<AuthForgotPasswordDto> get serializer => _$AuthForgotPasswordDtoSerializer();
}

class _$AuthForgotPasswordDtoSerializer implements StructuredSerializer<AuthForgotPasswordDto> {
    @override
    final Iterable<Type> types = const [AuthForgotPasswordDto, _$AuthForgotPasswordDto];

    @override
    final String wireName = r'AuthForgotPasswordDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, AuthForgotPasswordDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'email')
            ..add(object.email == null ? null : serializers.serialize(object.email,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'phone')
            ..add(object.phone == null ? null : serializers.serialize(object.phone,
                specifiedType: const FullType.nullable(String)));
        return result;
    }

    @override
    AuthForgotPasswordDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AuthForgotPasswordDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.email = valueDes;
                    break;
                case r'phone':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.phone = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

