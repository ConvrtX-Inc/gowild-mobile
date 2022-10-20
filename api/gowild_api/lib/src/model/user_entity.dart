//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/user_entity_picture.dart';
import 'package:gowild_api/src/model/user_entity_status.dart';
import 'package:gowild_api/src/model/gender_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_entity.g.dart';

/// UserEntity
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [firstName] 
/// * [lastName] 
/// * [birthDate] 
/// * [gender] 
/// * [username] 
/// * [email] 
/// * [phoneNo] 
/// * [picture] 
/// * [status] 
abstract class UserEntity implements Built<UserEntity, UserEntityBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'firstName')
    String? get firstName;

    @BuiltValueField(wireName: r'lastName')
    String? get lastName;

    @BuiltValueField(wireName: r'birthDate')
    DateTime? get birthDate;

    @BuiltValueField(wireName: r'gender')
    GenderEnum get gender;
    // enum genderEnum {  male,  female,  other,  };

    @BuiltValueField(wireName: r'username')
    String? get username;

    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'phoneNo')
    String? get phoneNo;

    @BuiltValueField(wireName: r'picture')
    UserEntityPicture? get picture;

    @BuiltValueField(wireName: r'status')
    UserEntityStatus? get status;

    UserEntity._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserEntityBuilder b) => b;

    factory UserEntity([void updates(UserEntityBuilder b)]) = _$UserEntity;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserEntity> get serializer => _$UserEntitySerializer();
}

class _$UserEntitySerializer implements StructuredSerializer<UserEntity> {
    @override
    final Iterable<Type> types = const [UserEntity, _$UserEntity];

    @override
    final String wireName = r'UserEntity';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserEntity object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'createdDate')
            ..add(object.createdDate == null ? null : serializers.serialize(object.createdDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'updatedDate')
            ..add(object.updatedDate == null ? null : serializers.serialize(object.updatedDate,
                specifiedType: const FullType.nullable(DateTime)));
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
            ..add(serializers.serialize(object.gender,
                specifiedType: const FullType(GenderEnum)));
        result
            ..add(r'username')
            ..add(object.username == null ? null : serializers.serialize(object.username,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        result
            ..add(r'phoneNo')
            ..add(object.phoneNo == null ? null : serializers.serialize(object.phoneNo,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'picture')
            ..add(object.picture == null ? null : serializers.serialize(object.picture,
                specifiedType: const FullType.nullable(UserEntityPicture)));
        result
            ..add(r'status')
            ..add(object.status == null ? null : serializers.serialize(object.status,
                specifiedType: const FullType.nullable(UserEntityStatus)));
        return result;
    }

    @override
    UserEntity deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserEntityBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.id = valueDes;
                    break;
                case r'createdDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.createdDate = valueDes;
                    break;
                case r'updatedDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.updatedDate = valueDes;
                    break;
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
                        specifiedType: const FullType(GenderEnum)) as GenderEnum;
                    result.gender = valueDes;
                    break;
                case r'username':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.username = valueDes;
                    break;
                case r'email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.email = valueDes;
                    break;
                case r'phoneNo':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.phoneNo = valueDes;
                    break;
                case r'picture':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(UserEntityPicture)) as UserEntityPicture?;
                    if (valueDes == null) continue;
                    result.picture.replace(valueDes);
                    break;
                case r'status':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(UserEntityStatus)) as UserEntityStatus?;
                    if (valueDes == null) continue;
                    result.status.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

