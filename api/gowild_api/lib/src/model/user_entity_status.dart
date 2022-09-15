//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_entity_status.g.dart';

/// UserEntityStatus
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [statusName] 
/// * [isActive] 
abstract class UserEntityStatus implements Built<UserEntityStatus, UserEntityStatusBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'statusName')
    UserEntityStatusStatusNameEnum get statusName;
    // enum statusNameEnum {  cancelled,  active,  disabled,  approved,  refunded,  rejected,  completed,  pending,  inactive,  };

    @BuiltValueField(wireName: r'isActive')
    bool get isActive;

    UserEntityStatus._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserEntityStatusBuilder b) => b;

    factory UserEntityStatus([void updates(UserEntityStatusBuilder b)]) = _$UserEntityStatus;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserEntityStatus> get serializer => _$UserEntityStatusSerializer();
}

class _$UserEntityStatusSerializer implements StructuredSerializer<UserEntityStatus> {
    @override
    final Iterable<Type> types = const [UserEntityStatus, _$UserEntityStatus];

    @override
    final String wireName = r'UserEntityStatus';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserEntityStatus object,
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
                specifiedType: const FullType(UserEntityStatusStatusNameEnum)));
        result
            ..add(r'isActive')
            ..add(serializers.serialize(object.isActive,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    UserEntityStatus deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserEntityStatusBuilder();

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
                        specifiedType: const FullType(UserEntityStatusStatusNameEnum)) as UserEntityStatusStatusNameEnum;
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

class UserEntityStatusStatusNameEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cancelled')
  static const UserEntityStatusStatusNameEnum cancelled = _$userEntityStatusStatusNameEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'active')
  static const UserEntityStatusStatusNameEnum active = _$userEntityStatusStatusNameEnum_active;
  @BuiltValueEnumConst(wireName: r'disabled')
  static const UserEntityStatusStatusNameEnum disabled = _$userEntityStatusStatusNameEnum_disabled;
  @BuiltValueEnumConst(wireName: r'approved')
  static const UserEntityStatusStatusNameEnum approved = _$userEntityStatusStatusNameEnum_approved;
  @BuiltValueEnumConst(wireName: r'refunded')
  static const UserEntityStatusStatusNameEnum refunded = _$userEntityStatusStatusNameEnum_refunded;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const UserEntityStatusStatusNameEnum rejected = _$userEntityStatusStatusNameEnum_rejected;
  @BuiltValueEnumConst(wireName: r'completed')
  static const UserEntityStatusStatusNameEnum completed = _$userEntityStatusStatusNameEnum_completed;
  @BuiltValueEnumConst(wireName: r'pending')
  static const UserEntityStatusStatusNameEnum pending = _$userEntityStatusStatusNameEnum_pending;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const UserEntityStatusStatusNameEnum inactive = _$userEntityStatusStatusNameEnum_inactive;

  static Serializer<UserEntityStatusStatusNameEnum> get serializer => _$userEntityStatusStatusNameEnumSerializer;

  const UserEntityStatusStatusNameEnum._(String name): super(name);

  static BuiltSet<UserEntityStatusStatusNameEnum> get values => _$userEntityStatusStatusNameEnumValues;
  static UserEntityStatusStatusNameEnum valueOf(String name) => _$userEntityStatusStatusNameEnumValueOf(name);
}

