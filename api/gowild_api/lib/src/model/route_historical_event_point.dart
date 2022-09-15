//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/app_point.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_historical_event_point.g.dart';

/// RouteHistoricalEventPoint
///
/// Properties:
/// * [type] 
/// * [coordinates] 
abstract class RouteHistoricalEventPoint implements Built<RouteHistoricalEventPoint, RouteHistoricalEventPointBuilder> {
    @BuiltValueField(wireName: r'type')
    RouteHistoricalEventPointTypeEnum get type;
    // enum typeEnum {  Point,  };

    @BuiltValueField(wireName: r'coordinates')
    BuiltList<double> get coordinates;

    RouteHistoricalEventPoint._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(RouteHistoricalEventPointBuilder b) => b;

    factory RouteHistoricalEventPoint([void updates(RouteHistoricalEventPointBuilder b)]) = _$RouteHistoricalEventPoint;

    @BuiltValueSerializer(custom: true)
    static Serializer<RouteHistoricalEventPoint> get serializer => _$RouteHistoricalEventPointSerializer();
}

class _$RouteHistoricalEventPointSerializer implements StructuredSerializer<RouteHistoricalEventPoint> {
    @override
    final Iterable<Type> types = const [RouteHistoricalEventPoint, _$RouteHistoricalEventPoint];

    @override
    final String wireName = r'RouteHistoricalEventPoint';

    @override
    Iterable<Object?> serialize(Serializers serializers, RouteHistoricalEventPoint object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(RouteHistoricalEventPointTypeEnum)));
        result
            ..add(r'coordinates')
            ..add(serializers.serialize(object.coordinates,
                specifiedType: const FullType(BuiltList, [FullType(double)])));
        return result;
    }

    @override
    RouteHistoricalEventPoint deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = RouteHistoricalEventPointBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'type':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(RouteHistoricalEventPointTypeEnum)) as RouteHistoricalEventPointTypeEnum;
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

class RouteHistoricalEventPointTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Point')
  static const RouteHistoricalEventPointTypeEnum point = _$routeHistoricalEventPointTypeEnum_point;

  static Serializer<RouteHistoricalEventPointTypeEnum> get serializer => _$routeHistoricalEventPointTypeEnumSerializer;

  const RouteHistoricalEventPointTypeEnum._(String name): super(name);

  static BuiltSet<RouteHistoricalEventPointTypeEnum> get values => _$routeHistoricalEventPointTypeEnumValues;
  static RouteHistoricalEventPointTypeEnum valueOf(String name) => _$routeHistoricalEventPointTypeEnumValueOf(name);
}

