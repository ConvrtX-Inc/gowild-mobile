//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_register_login_dto.g.dart';

/// AuthRegisterLoginDto
///
/// Properties:
/// * [email] 
/// * [password] 
/// * [fullName] 
/// * [firstName] 
/// * [lastName] 
/// * [gender] 
/// * [addressLine1] 
/// * [addressLine2] 
/// * [phoneNo] 
/// * [statusId] 
abstract class AuthRegisterLoginDto implements Built<AuthRegisterLoginDto, AuthRegisterLoginDtoBuilder> {
    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'password')
    String get password;

    @BuiltValueField(wireName: r'full_name')
    String get fullName;

    @BuiltValueField(wireName: r'first_name')
    String get firstName;

    @BuiltValueField(wireName: r'last_name')
    String get lastName;

    @BuiltValueField(wireName: r'gender')
    AuthRegisterLoginDtoGenderEnum get gender;
    // enum genderEnum {  Male,  Female,  };

    @BuiltValueField(wireName: r'address_line1')
    String get addressLine1;

    @BuiltValueField(wireName: r'address_line2')
    String get addressLine2;

    @BuiltValueField(wireName: r'phone_no')
    String get phoneNo;

    @BuiltValueField(wireName: r'status_id')
    AuthRegisterLoginDtoStatusIdEnum get statusId;
    // enum statusIdEnum {  Cancelled,  Active,  Disabled,  Approved,  Refunded,  Rejected,  Completed,  Pending,  Inactive,  };

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
            ..add(r'full_name')
            ..add(serializers.serialize(object.fullName,
                specifiedType: const FullType(String)));
        result
            ..add(r'first_name')
            ..add(serializers.serialize(object.firstName,
                specifiedType: const FullType(String)));
        result
            ..add(r'last_name')
            ..add(serializers.serialize(object.lastName,
                specifiedType: const FullType(String)));
        result
            ..add(r'gender')
            ..add(serializers.serialize(object.gender,
                specifiedType: const FullType(AuthRegisterLoginDtoGenderEnum)));
        result
            ..add(r'address_line1')
            ..add(serializers.serialize(object.addressLine1,
                specifiedType: const FullType(String)));
        result
            ..add(r'address_line2')
            ..add(serializers.serialize(object.addressLine2,
                specifiedType: const FullType(String)));
        result
            ..add(r'phone_no')
            ..add(serializers.serialize(object.phoneNo,
                specifiedType: const FullType(String)));
        result
            ..add(r'status_id')
            ..add(serializers.serialize(object.statusId,
                specifiedType: const FullType(AuthRegisterLoginDtoStatusIdEnum)));
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
                case r'full_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.fullName = valueDes;
                    break;
                case r'first_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.firstName = valueDes;
                    break;
                case r'last_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.lastName = valueDes;
                    break;
                case r'gender':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(AuthRegisterLoginDtoGenderEnum)) as AuthRegisterLoginDtoGenderEnum;
                    result.gender = valueDes;
                    break;
                case r'address_line1':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.addressLine1 = valueDes;
                    break;
                case r'address_line2':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.addressLine2 = valueDes;
                    break;
                case r'phone_no':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.phoneNo = valueDes;
                    break;
                case r'status_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(AuthRegisterLoginDtoStatusIdEnum)) as AuthRegisterLoginDtoStatusIdEnum;
                    result.statusId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

class AuthRegisterLoginDtoGenderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Male')
  static const AuthRegisterLoginDtoGenderEnum male = _$authRegisterLoginDtoGenderEnum_male;
  @BuiltValueEnumConst(wireName: r'Female')
  static const AuthRegisterLoginDtoGenderEnum female = _$authRegisterLoginDtoGenderEnum_female;

  static Serializer<AuthRegisterLoginDtoGenderEnum> get serializer => _$authRegisterLoginDtoGenderEnumSerializer;

  const AuthRegisterLoginDtoGenderEnum._(String name): super(name);

  static BuiltSet<AuthRegisterLoginDtoGenderEnum> get values => _$authRegisterLoginDtoGenderEnumValues;
  static AuthRegisterLoginDtoGenderEnum valueOf(String name) => _$authRegisterLoginDtoGenderEnumValueOf(name);
}

class AuthRegisterLoginDtoStatusIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Cancelled')
  static const AuthRegisterLoginDtoStatusIdEnum cancelled = _$authRegisterLoginDtoStatusIdEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'Active')
  static const AuthRegisterLoginDtoStatusIdEnum active = _$authRegisterLoginDtoStatusIdEnum_active;
  @BuiltValueEnumConst(wireName: r'Disabled')
  static const AuthRegisterLoginDtoStatusIdEnum disabled = _$authRegisterLoginDtoStatusIdEnum_disabled;
  @BuiltValueEnumConst(wireName: r'Approved')
  static const AuthRegisterLoginDtoStatusIdEnum approved = _$authRegisterLoginDtoStatusIdEnum_approved;
  @BuiltValueEnumConst(wireName: r'Refunded')
  static const AuthRegisterLoginDtoStatusIdEnum refunded = _$authRegisterLoginDtoStatusIdEnum_refunded;
  @BuiltValueEnumConst(wireName: r'Rejected')
  static const AuthRegisterLoginDtoStatusIdEnum rejected = _$authRegisterLoginDtoStatusIdEnum_rejected;
  @BuiltValueEnumConst(wireName: r'Completed')
  static const AuthRegisterLoginDtoStatusIdEnum completed = _$authRegisterLoginDtoStatusIdEnum_completed;
  @BuiltValueEnumConst(wireName: r'Pending')
  static const AuthRegisterLoginDtoStatusIdEnum pending = _$authRegisterLoginDtoStatusIdEnum_pending;
  @BuiltValueEnumConst(wireName: r'Inactive')
  static const AuthRegisterLoginDtoStatusIdEnum inactive = _$authRegisterLoginDtoStatusIdEnum_inactive;

  static Serializer<AuthRegisterLoginDtoStatusIdEnum> get serializer => _$authRegisterLoginDtoStatusIdEnumSerializer;

  const AuthRegisterLoginDtoStatusIdEnum._(String name): super(name);

  static BuiltSet<AuthRegisterLoginDtoStatusIdEnum> get values => _$authRegisterLoginDtoStatusIdEnumValues;
  static AuthRegisterLoginDtoStatusIdEnum valueOf(String name) => _$authRegisterLoginDtoStatusIdEnumValueOf(name);
}

