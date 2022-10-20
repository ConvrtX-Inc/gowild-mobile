//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_point.g.dart';

/// AppPoint
///
/// Properties:
/// * [type] 
/// * [coordinates] 
abstract class AppPoint implements Built<AppPoint, AppPointBuilder> {
    @BuiltValueField(wireName: r'type')
    AppPointTypeEnum get type;
    // enum typeEnum {  Point,  };

    @BuiltValueField(wireName: r'coordinates')
    BuiltList<double> get coordinates;

    AppPoint._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AppPointBuilder b) => b;

    factory AppPoint([void updates(AppPointBuilder b)]) = _$AppPoint;

    @BuiltValueSerializer(custom: true)
    static Serializer<AppPoint> get serializer => _$AppPointSerializer();
}

class _$AppPointSerializer implements StructuredSerializer<AppPoint> {
    @override
    final Iterable<Type> types = const [AppPoint, _$AppPoint];

    @override
    final String wireName = r'AppPoint';

    @override
    Iterable<Object?> serialize(Serializers serializers, AppPoint object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(AppPointTypeEnum)));
        result
            ..add(r'coordinates')
            ..add(serializers.serialize(object.coordinates,
                specifiedType: const FullType(BuiltList, [FullType(double)])));
        return result;
    }

    @override
    AppPoint deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AppPointBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'type':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(AppPointTypeEnum)) as AppPointTypeEnum;
                    result.type = valueDes;
                    break;
                case r'coordinates':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(double)])) as BuiltList<double>;
                    result.coordinates.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

class AppPointTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Point')
  static const AppPointTypeEnum point = _$appPointTypeEnum_point;

  static Serializer<AppPointTypeEnum> get serializer => _$appPointTypeEnumSerializer;

  const AppPointTypeEnum._(String name): super(name);

  static BuiltSet<AppPointTypeEnum> get values => _$appPointTypeEnumValues;
  static AppPointTypeEnum valueOf(String name) => _$appPointTypeEnumValueOf(name);
}

