//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'status.g.dart';

/// Status
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [statusName] 
/// * [isActive] 
abstract class Status implements Built<Status, StatusBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'statusName')
    StatusStatusNameEnum get statusName;
    // enum statusNameEnum {  cancelled,  active,  disabled,  approved,  refunded,  rejected,  completed,  pending,  inactive,  };

    @BuiltValueField(wireName: r'isActive')
    bool get isActive;

    Status._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(StatusBuilder b) => b;

    factory Status([void updates(StatusBuilder b)]) = _$Status;

    @BuiltValueSerializer(custom: true)
    static Serializer<Status> get serializer => _$StatusSerializer();
}

class _$StatusSerializer implements StructuredSerializer<Status> {
    @override
    final Iterable<Type> types = const [Status, _$Status];

    @override
    final String wireName = r'Status';

    @override
    Iterable<Object?> serialize(Serializers serializers, Status object,
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
                specifiedType: const FullType(StatusStatusNameEnum)));
        result
            ..add(r'isActive')
            ..add(serializers.serialize(object.isActive,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    Status deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = StatusBuilder();

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
                        specifiedType: const FullType(StatusStatusNameEnum)) as StatusStatusNameEnum;
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

class StatusStatusNameEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cancelled')
  static const StatusStatusNameEnum cancelled = _$statusStatusNameEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'active')
  static const StatusStatusNameEnum active = _$statusStatusNameEnum_active;
  @BuiltValueEnumConst(wireName: r'disabled')
  static const StatusStatusNameEnum disabled = _$statusStatusNameEnum_disabled;
  @BuiltValueEnumConst(wireName: r'approved')
  static const StatusStatusNameEnum approved = _$statusStatusNameEnum_approved;
  @BuiltValueEnumConst(wireName: r'refunded')
  static const StatusStatusNameEnum refunded = _$statusStatusNameEnum_refunded;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const StatusStatusNameEnum rejected = _$statusStatusNameEnum_rejected;
  @BuiltValueEnumConst(wireName: r'completed')
  static const StatusStatusNameEnum completed = _$statusStatusNameEnum_completed;
  @BuiltValueEnumConst(wireName: r'pending')
  static const StatusStatusNameEnum pending = _$statusStatusNameEnum_pending;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const StatusStatusNameEnum inactive = _$statusStatusNameEnum_inactive;

  static Serializer<StatusStatusNameEnum> get serializer => _$statusStatusNameEnumSerializer;

  const StatusStatusNameEnum._(String name): super(name);

  static BuiltSet<StatusStatusNameEnum> get values => _$statusStatusNameEnumValues;
  static StatusStatusNameEnum valueOf(String name) => _$statusStatusNameEnumValueOf(name);
}

