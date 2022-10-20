//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_google_login_dto.g.dart';

/// AuthGoogleLoginDto
///
/// Properties:
/// * [idToken] 
abstract class AuthGoogleLoginDto implements Built<AuthGoogleLoginDto, AuthGoogleLoginDtoBuilder> {
    @BuiltValueField(wireName: r'id_token')
    String get idToken;

    AuthGoogleLoginDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AuthGoogleLoginDtoBuilder b) => b;

    factory AuthGoogleLoginDto([void updates(AuthGoogleLoginDtoBuilder b)]) = _$AuthGoogleLoginDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<AuthGoogleLoginDto> get serializer => _$AuthGoogleLoginDtoSerializer();
}

class _$AuthGoogleLoginDtoSerializer implements StructuredSerializer<AuthGoogleLoginDto> {
    @override
    final Iterable<Type> types = const [AuthGoogleLoginDto, _$AuthGoogleLoginDto];

    @override
    final String wireName = r'AuthGoogleLoginDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, AuthGoogleLoginDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id_token')
            ..add(serializers.serialize(object.idToken,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    AuthGoogleLoginDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AuthGoogleLoginDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id_token':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.idToken = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

