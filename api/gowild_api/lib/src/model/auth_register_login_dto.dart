//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/gender_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_register_login_dto.g.dart';

/// AuthRegisterLoginDto
///
/// Properties:
/// * [email] 
/// * [password] 
/// * [firstName] 
/// * [lastName] 
/// * [gender] 
/// * [phoneNo] 
abstract class AuthRegisterLoginDto implements Built<AuthRegisterLoginDto, AuthRegisterLoginDtoBuilder> {
    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'password')
    String get password;

    @BuiltValueField(wireName: r'firstName')
    String get firstName;

    @BuiltValueField(wireName: r'lastName')
    String get lastName;

    @BuiltValueField(wireName: r'gender')
    GenderEnum get gender;
    // enum genderEnum {  male,  female,  other,  };

    @BuiltValueField(wireName: r'phoneNo')
    String? get phoneNo;

    AuthRegisterLoginDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AuthRegisterLoginDtoBuilder b) => b;

    factory AuthRegisterLoginDto([void updates(AuthRegisterLoginDtoBuilder b)]) = _$AuthRegisterLoginDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<AuthRegisterLoginDto> get serializer => _$AuthRegisterLoginDtoSerializer();
}

class _$AuthRegisterLoginDtoSerializer implements StructuredSerializer<AuthRegisterLoginDto> {
    @override
    final Iterable<Type> types = const [AuthRegisterLoginDto, _$AuthRegisterLoginDto];

    @override
    final String wireName = r'AuthRegisterLoginDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, AuthRegisterLoginDto object,
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
        result
            ..add(r'firstName')
            ..add(serializers.serialize(object.firstName,
                specifiedType: const FullType(String)));
        result
            ..add(r'lastName')
            ..add(serializers.serialize(object.lastName,
                specifiedType: const FullType(String)));
        result
            ..add(r'gender')
            ..add(serializers.serialize(object.gender,
                specifiedType: const FullType(GenderEnum)));
        result
            ..add(r'phoneNo')
            ..add(object.phoneNo == null ? null : serializers.serialize(object.phoneNo,
                specifiedType: const FullType.nullable(String)));
        return result;
    }

    @override
    AuthRegisterLoginDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AuthRegisterLoginDtoBuilder();

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
                case r'firstName':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.firstName = valueDes;
                    break;
                case r'lastName':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.lastName = valueDes;
                    break;
                case r'gender':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(GenderEnum)) as GenderEnum;
                    result.gender = valueDes;
                    break;
                case r'phoneNo':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.phoneNo = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

