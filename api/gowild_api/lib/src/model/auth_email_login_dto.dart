//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_email_login_dto.g.dart';

/// AuthEmailLoginDto
///
/// Properties:
/// * [email] 
/// * [password] 
abstract class AuthEmailLoginDto implements Built<AuthEmailLoginDto, AuthEmailLoginDtoBuilder> {
    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'password')
    String get password;

    AuthEmailLoginDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AuthEmailLoginDtoBuilder b) => b;

    factory AuthEmailLoginDto([void updates(AuthEmailLoginDtoBuilder b)]) = _$AuthEmailLoginDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<AuthEmailLoginDto> get serializer => _$AuthEmailLoginDtoSerializer();
}

class _$AuthEmailLoginDtoSerializer implements StructuredSerializer<AuthEmailLoginDto> {
    @override
    final Iterable<Type> types = const [AuthEmailLoginDto, _$AuthEmailLoginDto];

    @override
    final String wireName = r'AuthEmailLoginDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, AuthEmailLoginDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        result
            ..add(r'password')
            ..add(serializers.serialize(object.password,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    AuthEmailLoginDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AuthEmailLoginDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.email = valueDes;
                    break;
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

