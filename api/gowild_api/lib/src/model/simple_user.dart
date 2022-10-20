//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'simple_user.g.dart';

/// SimpleUser
///
/// Properties:
/// * [firstName] 
/// * [lastName] 
/// * [birthDate] 
/// * [gender] 
/// * [username] 
/// * [phoneNo] 
/// * [email] 
/// * [fullName] 
/// * [picture] 
abstract class SimpleUser implements Built<SimpleUser, SimpleUserBuilder> {
    @BuiltValueField(wireName: r'firstName')
    String? get firstName;

    @BuiltValueField(wireName: r'lastName')
    String? get lastName;

    @BuiltValueField(wireName: r'birthDate')
    DateTime? get birthDate;

    @BuiltValueField(wireName: r'gender')
    String? get gender;

    @BuiltValueField(wireName: r'username')
    String? get username;

    @BuiltValueField(wireName: r'phoneNo')
    String? get phoneNo;

    @BuiltValueField(wireName: r'email')
    String? get email;

    @BuiltValueField(wireName: r'fullName')
    String? get fullName;

    @BuiltValueField(wireName: r'picture')
    String? get picture;

    SimpleUser._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SimpleUserBuilder b) => b;

    factory SimpleUser([void updates(SimpleUserBuilder b)]) = _$SimpleUser;

    @BuiltValueSerializer(custom: true)
    static Serializer<SimpleUser> get serializer => _$SimpleUserSerializer();
}

class _$SimpleUserSerializer implements StructuredSerializer<SimpleUser> {
    @override
    final Iterable<Type> types = const [SimpleUser, _$SimpleUser];

    @override
    final String wireName = r'SimpleUser';

    @override
    Iterable<Object?> serialize(Serializers serializers, SimpleUser object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'firstName')
            ..add(object.firstName == null ? null : serializers.serialize(object.firstName,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'lastName')
            ..add(object.lastName == null ? null : serializers.serialize(object.lastName,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'birthDate')
            ..add(object.birthDate == null ? null : serializers.serialize(object.birthDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'gender')
            ..add(object.gender == null ? null : serializers.serialize(object.gender,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'username')
            ..add(object.username == null ? null : serializers.serialize(object.username,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'phoneNo')
            ..add(object.phoneNo == null ? null : serializers.serialize(object.phoneNo,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'email')
            ..add(object.email == null ? null : serializers.serialize(object.email,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'fullName')
            ..add(object.fullName == null ? null : serializers.serialize(object.fullName,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'picture')
            ..add(object.picture == null ? null : serializers.serialize(object.picture,
                specifiedType: const FullType.nullable(String)));
        return result;
    }

    @override
    SimpleUser deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SimpleUserBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'firstName':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.firstName = valueDes;
                    break;
                case r'lastName':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.lastName = valueDes;
                    break;
                case r'birthDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.birthDate = valueDes;
                    break;
                case r'gender':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.gender = valueDes;
                    break;
                case r'username':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.username = valueDes;
                    break;
                case r'phoneNo':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.phoneNo = valueDes;
                    break;
                case r'email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.email = valueDes;
                    break;
                case r'fullName':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.fullName = valueDes;
                    break;
                case r'picture':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.picture = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

