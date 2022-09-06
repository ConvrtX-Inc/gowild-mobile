//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/user_status.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

/// User
///
/// Properties:
/// * [id] 
/// * [fullName] 
/// * [firstName] 
/// * [lastName] 
/// * [birthDate] 
/// * [gender] 
/// * [firebaseSnapshotId1Img] 
/// * [firebaseSnapshotId2Img] 
/// * [username] 
/// * [email] 
/// * [password] 
/// * [phoneNo] 
/// * [addressLine1] 
/// * [addressLine2] 
/// * [profilePhoto] 
/// * [imgUrl] 
/// * [hash] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [deletedDate] 
/// * [statusId] 
/// * [status] 
abstract class User implements Built<User, UserBuilder> {
    @BuiltValueField(wireName: r'id')
    String? get id;

    @BuiltValueField(wireName: r'full_name')
    String? get fullName;

    @BuiltValueField(wireName: r'first_name')
    String? get firstName;

    @BuiltValueField(wireName: r'last_name')
    String? get lastName;

    @BuiltValueField(wireName: r'birth_date')
    DateTime? get birthDate;

    @BuiltValueField(wireName: r'gender')
    String? get gender;

    @BuiltValueField(wireName: r'firebase_snapshot_id1_img')
    String? get firebaseSnapshotId1Img;

    @BuiltValueField(wireName: r'firebase_snapshot_id2_img')
    String? get firebaseSnapshotId2Img;

    @BuiltValueField(wireName: r'username')
    String? get username;

    @BuiltValueField(wireName: r'email')
    String? get email;

    @BuiltValueField(wireName: r'password')
    String? get password;

    @BuiltValueField(wireName: r'phone_no')
    String? get phoneNo;

    @BuiltValueField(wireName: r'address_line1')
    String? get addressLine1;

    @BuiltValueField(wireName: r'address_line2')
    String? get addressLine2;

    @BuiltValueField(wireName: r'profile_photo')
    JsonObject? get profilePhoto;

    @BuiltValueField(wireName: r'img_url')
    String? get imgUrl;

    @BuiltValueField(wireName: r'hash')
    String? get hash;

    @BuiltValueField(wireName: r'created_date')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updated_date')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'deleted_date')
    DateTime? get deletedDate;

    @BuiltValueField(wireName: r'status_id')
    num? get statusId;

    @BuiltValueField(wireName: r'status')
    UserStatus? get status;

    User._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserBuilder b) => b;

    factory User([void updates(UserBuilder b)]) = _$User;

    @BuiltValueSerializer(custom: true)
    static Serializer<User> get serializer => _$UserSerializer();
}

class _$UserSerializer implements StructuredSerializer<User> {
    @override
    final Iterable<Type> types = const [User, _$User];

    @override
    final String wireName = r'User';

    @override
    Iterable<Object?> serialize(Serializers serializers, User object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(object.id == null ? null : serializers.serialize(object.id,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'full_name')
            ..add(object.fullName == null ? null : serializers.serialize(object.fullName,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'first_name')
            ..add(object.firstName == null ? null : serializers.serialize(object.firstName,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'last_name')
            ..add(object.lastName == null ? null : serializers.serialize(object.lastName,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'birth_date')
            ..add(object.birthDate == null ? null : serializers.serialize(object.birthDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'gender')
            ..add(object.gender == null ? null : serializers.serialize(object.gender,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'firebase_snapshot_id1_img')
            ..add(object.firebaseSnapshotId1Img == null ? null : serializers.serialize(object.firebaseSnapshotId1Img,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'firebase_snapshot_id2_img')
            ..add(object.firebaseSnapshotId2Img == null ? null : serializers.serialize(object.firebaseSnapshotId2Img,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'username')
            ..add(object.username == null ? null : serializers.serialize(object.username,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'email')
            ..add(object.email == null ? null : serializers.serialize(object.email,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'password')
            ..add(object.password == null ? null : serializers.serialize(object.password,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'phone_no')
            ..add(object.phoneNo == null ? null : serializers.serialize(object.phoneNo,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'address_line1')
            ..add(object.addressLine1 == null ? null : serializers.serialize(object.addressLine1,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'address_line2')
            ..add(object.addressLine2 == null ? null : serializers.serialize(object.addressLine2,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'profile_photo')
            ..add(object.profilePhoto == null ? null : serializers.serialize(object.profilePhoto,
                specifiedType: const FullType.nullable(JsonObject)));
        result
            ..add(r'img_url')
            ..add(object.imgUrl == null ? null : serializers.serialize(object.imgUrl,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'hash')
            ..add(object.hash == null ? null : serializers.serialize(object.hash,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'created_date')
            ..add(object.createdDate == null ? null : serializers.serialize(object.createdDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'updated_date')
            ..add(object.updatedDate == null ? null : serializers.serialize(object.updatedDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'deleted_date')
            ..add(object.deletedDate == null ? null : serializers.serialize(object.deletedDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'status_id')
            ..add(object.statusId == null ? null : serializers.serialize(object.statusId,
                specifiedType: const FullType.nullable(num)));
        result
            ..add(r'status')
            ..add(object.status == null ? null : serializers.serialize(object.status,
                specifiedType: const FullType.nullable(UserStatus)));
        return result;
    }

    @override
    User deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.id = valueDes;
                    break;
                case r'full_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.fullName = valueDes;
                    break;
                case r'first_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.firstName = valueDes;
                    break;
                case r'last_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.lastName = valueDes;
                    break;
                case r'birth_date':
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
                case r'firebase_snapshot_id1_img':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.firebaseSnapshotId1Img = valueDes;
                    break;
                case r'firebase_snapshot_id2_img':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.firebaseSnapshotId2Img = valueDes;
                    break;
                case r'username':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.username = valueDes;
                    break;
                case r'email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.email = valueDes;
                    break;
                case r'password':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.password = valueDes;
                    break;
                case r'phone_no':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.phoneNo = valueDes;
                    break;
                case r'address_line1':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.addressLine1 = valueDes;
                    break;
                case r'address_line2':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.addressLine2 = valueDes;
                    break;
                case r'profile_photo':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(JsonObject)) as JsonObject?;
                    if (valueDes == null) continue;
                    result.profilePhoto = valueDes;
                    break;
                case r'img_url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.imgUrl = valueDes;
                    break;
                case r'hash':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.hash = valueDes;
                    break;
                case r'created_date':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.createdDate = valueDes;
                    break;
                case r'updated_date':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.updatedDate = valueDes;
                    break;
                case r'deleted_date':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.deletedDate = valueDes;
                    break;
                case r'status_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(num)) as num?;
                    if (valueDes == null) continue;
                    result.statusId = valueDes;
                    break;
                case r'status':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(UserStatus)) as UserStatus?;
                    if (valueDes == null) continue;
                    result.status.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

