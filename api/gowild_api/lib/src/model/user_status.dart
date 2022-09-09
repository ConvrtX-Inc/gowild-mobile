//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_status.g.dart';

/// UserStatus
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [statusName] 
/// * [isActive] 
abstract class UserStatus implements Built<UserStatus, UserStatusBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'statusName')
    UserStatusStatusNameEnum get statusName;
    // enum statusNameEnum {  cancelled,  active,  disabled,  approved,  refunded,  rejected,  completed,  pending,  inactive,  };

    @BuiltValueField(wireName: r'isActive')
    bool get isActive;

    UserStatus._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserStatusBuilder b) => b;

    factory UserStatus([void updates(UserStatusBuilder b)]) = _$UserStatus;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserStatus> get serializer => _$UserStatusSerializer();
}

class _$UserStatusSerializer implements StructuredSerializer<UserStatus> {
    @override
    final Iterable<Type> types = const [UserStatus, _$UserStatus];

    @override
    final String wireName = r'UserStatus';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserStatus object,
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
            ..add(r'statusName')
            ..add(serializers.serialize(object.statusName,
                specifiedType: const FullType(UserStatusStatusNameEnum)));
        result
            ..add(r'isActive')
            ..add(serializers.serialize(object.isActive,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    UserStatus deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserStatusBuilder();

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
                case r'statusName':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(UserStatusStatusNameEnum)) as UserStatusStatusNameEnum;
                    result.statusName = valueDes;
                    break;
                case r'isActive':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.isActive = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

class UserStatusStatusNameEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cancelled')
  static const UserStatusStatusNameEnum cancelled = _$userStatusStatusNameEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'active')
  static const UserStatusStatusNameEnum active = _$userStatusStatusNameEnum_active;
  @BuiltValueEnumConst(wireName: r'disabled')
  static const UserStatusStatusNameEnum disabled = _$userStatusStatusNameEnum_disabled;
  @BuiltValueEnumConst(wireName: r'approved')
  static const UserStatusStatusNameEnum approved = _$userStatusStatusNameEnum_approved;
  @BuiltValueEnumConst(wireName: r'refunded')
  static const UserStatusStatusNameEnum refunded = _$userStatusStatusNameEnum_refunded;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const UserStatusStatusNameEnum rejected = _$userStatusStatusNameEnum_rejected;
  @BuiltValueEnumConst(wireName: r'completed')
  static const UserStatusStatusNameEnum completed = _$userStatusStatusNameEnum_completed;
  @BuiltValueEnumConst(wireName: r'pending')
  static const UserStatusStatusNameEnum pending = _$userStatusStatusNameEnum_pending;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const UserStatusStatusNameEnum inactive = _$userStatusStatusNameEnum_inactive;

  static Serializer<UserStatusStatusNameEnum> get serializer => _$userStatusStatusNameEnumSerializer;

  const UserStatusStatusNameEnum._(String name): super(name);

  static BuiltSet<UserStatusStatusNameEnum> get values => _$userStatusStatusNameEnumValues;
  static UserStatusStatusNameEnum valueOf(String name) => _$userStatusStatusNameEnumValueOf(name);
}

